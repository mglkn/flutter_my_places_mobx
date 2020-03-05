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

part 'place_form.g.dart';

class PlaceFormStore = _PlaceFormStore with _$PlaceFormStore;

abstract class _PlaceFormStore with Store implements Disposable {
  final DbDataRepository _repo;
  StreamSubscription<ConnectivityResult> _subscription;

  @observable
  dynamic _place;
  get place => _place as Place;
  set place(Place newValue) => _place = newValue;

  _PlaceFormStore({DbDataRepository repo})
      : _repo = repo ?? DbDataRepository.db() {
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
    List<Address> locations = [];

    final coordinates = Coordinates(latitude, longitude);
    try {
      locations =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
    } on PlatformException catch (_) {
      if (isInternetConnected) {
        locationError = 'Internet connection error, try reload app';
      }
    } catch (_) {
      locationError = 'Something went wrong, try reload app';
    }

    if (locations.length > 0) {
      location = locations.first;
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

  @computed
  String get address => location != null
      ? '${location.locality}, ${location.thoroughfare}, ${location.featureName}'
      : addressOffline != null ? addressOffline : null;

  bool isFormValid() {
    return name.length != 0;
  }

  @action
  savePlace() {
    final image = imageBase64 != null
        ? imageBase64
        : imageFile != null ? base64Encode(imageFile.readAsBytesSync()) : null;

    final String coordinates = location == null
        ? null
        : '${location.coordinates.latitude},${location.coordinates.longitude}';

    if (_place != null) {
      return _repo.updatePlace(
        _place.copyWith(
          name: name,
          type: type,
          rate: rate,
          image: image,
          address: address,
          coordinates: coordinates,
        ),
      );
    }

    return _repo.createPlace(
      Place(
        name: name,
        type: type,
        rate: rate,
        image: image,
        address: address,
        coordinates: coordinates,
      ),
    );
  }
}
