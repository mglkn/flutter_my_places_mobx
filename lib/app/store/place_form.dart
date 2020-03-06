import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoder/geocoder.dart';
import 'package:mobx/mobx.dart';
import 'package:connectivity/connectivity.dart';

import '../data/db.dart';
import '../data/db_repository.dart';
import '../services/geocoder_service.dart';

part 'place_form.g.dart';

class PlaceFormStore = _PlaceFormStore with _$PlaceFormStore;

abstract class _PlaceFormStore with Store implements Disposable {
  final DbDataRepository _repo;
  final GeocoderService _geocoderService;
  StreamSubscription<ConnectivityResult> _subscription;

  @observable
  dynamic _place;
  get place => _place as Place;
  set place(Place newValue) => _place = newValue;

  _PlaceFormStore({DbDataRepository repo, GeocoderService geocoderService})
      : _repo = repo ?? DbDataRepository.db(),
        _geocoderService = geocoderService ?? GeocoderService.instance() {
    Connectivity().checkConnectivity().then(_connectivityCb);

    _subscription =
        Connectivity().onConnectivityChanged.listen(_connectivityCb);
  }

  void _connectivityCb(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      isInternetConnected = false;
      return;
    }

    isInternetConnected = true;
  }

  @override
  void dispose() {
    _subscription.cancel();
  }

  _setLocation() async {
    final c = _place.coordinates
        .split(',')
        .map<double>((String s) => double.parse(s))
        .toList();
    final latitude = c[0];
    final longitude = c[1];

    Address _location;

    try {
      _location = await _geocoderService.getAddress(
          latitude: latitude, longitude: longitude);
    } on PlatformException catch (_) {
      if (isInternetConnected) {
        locationError = 'Internet connection error, try reload app';
      }
    } catch (_) {
      locationError = 'Something went wrong, try reload app';
    }

    if (_location != null) {
      location = _location;
      return;
    }

    addressOffline = _place.address ?? '';
  }

  void init(Place place) {
    _place = null;

    // reset form
    if (place == null) {
      name = '';
      type = '';
      rate = 0;
      imageBase64 = null;
      imageFile = null;
      location = null;
      return;
    }

    _place = place;

    if (_place.coordinates != null) {
      _setLocation();
    }

    name = _place.name;
    type = _place.type;
    rate = _place.rate;
    imageBase64 = _place.image;
  }

  @observable
  bool isInternetConnected = false;

  @observable
  String name;

  @observable
  String type;

  @observable
  Address location;

  @observable
  String addressOffline;

  @observable
  File imageFile;

  @observable
  String imageBase64;

  @observable
  int rate;

  @observable
  String locationError;

  @observable
  String nameFieldError;

  @observable
  String typeFieldError;

  @computed
  String get address => location != null
      ? _geocoderService.getShortAddress(location)
      : addressOffline != null ? addressOffline : null;

  @action
  void checkValidation() {
    nameFieldError = null;
    typeFieldError = null;

    if (name.length == 0) {
      nameFieldError = 'This field should\'t be empty';
    }

    if (type.length == 0) {
      typeFieldError = 'This field should\'t be empty';
    }
  }

  @action
  Future<bool> savePlace() async {
    checkValidation();
    if (nameFieldError.length > 0 || typeFieldError.length > 0) return false;

    final image = imageBase64 != null
        ? imageBase64
        : imageFile != null ? base64Encode(imageFile.readAsBytesSync()) : null;

    final String coordinates = location == null
        ? null
        : '${location.coordinates.latitude},${location.coordinates.longitude}';

    if (_place != null) {
      await _repo.updatePlace(
        _place.copyWith(
          name: name,
          type: type,
          rate: rate,
          image: image,
          address: address,
          coordinates: coordinates,
        ),
      );
      return true;
    }

    await _repo.createPlace(
      Place(
        name: name,
        type: type,
        rate: rate,
        image: image,
        address: address,
        coordinates: coordinates,
      ),
    );
    return true;
  }
}
