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

  Place _place;

  _PlaceFormStore({DbDataRepository repo})
      : _repo = repo ?? DbDataRepository.db();

  init(Place place) {
    if (place = null) return;
    _place = place;

    name = _place.name;
    type = _place.type;
    rate = _place.rate;
    // TODO: init image and location (maybe save coordinates?)
  }

  @observable
  String name;

  @observable
  String type;

  @observable
  Address location;

  @observable
  File image;

  @observable
  int rate;

  bool isFormValid() {
    return name.length != 0;
  }

  @action
  createPlace() {
    return _repo.createPlace(
      Place(
        name: name,
        type: type,
        location: location.addressLine,
        rate: rate,
        image: base64Encode(image.readAsBytesSync()),
      ),
    );
  }
}
