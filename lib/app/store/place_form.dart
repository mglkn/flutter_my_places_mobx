import 'dart:convert';
import 'dart:io';

import 'package:geocoder/geocoder.dart';
import 'package:mobx/mobx.dart';

import '../data/db.dart';
import '../data/db_repository.dart';

part 'place_form.g.dart';

class PlaceFormStore = _PlaceFormStore with _$PlaceFormStore;

abstract class _PlaceFormStore with Store {
  final DbDataRepository _repo;

  @observable
  dynamic _place;
  get place => _place as Place;
  set place(Place newValue) => _place = newValue;

  _PlaceFormStore({DbDataRepository repo})
      : _repo = repo ?? DbDataRepository.db();

  init(Place place) {
    if (place == null) return;
    _place = place;

    name = _place.name;
    type = _place.type;
    rate = _place.rate;
    imageBase64 = _place.image;
    // TODO: init image and location (maybe save coordinates?)
  }

  @observable
  String name;

  @observable
  String type;

  @observable
  Address location;

  @observable
  File imageFile;

  @observable
  String imageBase64;

  @observable
  int rate;

  bool isFormValid() {
    return name.length != 0;
  }

  @action
  savePlace() {
    final image = imageBase64 != null
        ? imageBase64
        : imageFile != null ? base64Encode(imageFile.readAsBytesSync()) : null;

    if (_place != null) {
      return _repo.updatePlace(
        _place.copyWith(
          name: name,
          type: type,
          rate: rate,
          image: image,
        ),
      );
    }
    return _repo.createPlace(
      Place(
        name: name,
        type: type,
        // location: location.addressLine,
        rate: rate,
        image: image,
      ),
    );
  }
}
