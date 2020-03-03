// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_form.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceFormStore on _PlaceFormStore, Store {
  final _$nameAtom = Atom(name: '_PlaceFormStore.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$typeAtom = Atom(name: '_PlaceFormStore.type');

  @override
  String get type {
    _$typeAtom.context.enforceReadPolicy(_$typeAtom);
    _$typeAtom.reportObserved();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.context.conditionallyRunInAction(() {
      super.type = value;
      _$typeAtom.reportChanged();
    }, _$typeAtom, name: '${_$typeAtom.name}_set');
  }

  final _$locationAtom = Atom(name: '_PlaceFormStore.location');

  @override
  Address get location {
    _$locationAtom.context.enforceReadPolicy(_$locationAtom);
    _$locationAtom.reportObserved();
    return super.location;
  }

  @override
  set location(Address value) {
    _$locationAtom.context.conditionallyRunInAction(() {
      super.location = value;
      _$locationAtom.reportChanged();
    }, _$locationAtom, name: '${_$locationAtom.name}_set');
  }

  final _$imageFileAtom = Atom(name: '_PlaceFormStore.imageFile');

  @override
  File get imageFile {
    _$imageFileAtom.context.enforceReadPolicy(_$imageFileAtom);
    _$imageFileAtom.reportObserved();
    return super.imageFile;
  }

  @override
  set imageFile(File value) {
    _$imageFileAtom.context.conditionallyRunInAction(() {
      super.imageFile = value;
      _$imageFileAtom.reportChanged();
    }, _$imageFileAtom, name: '${_$imageFileAtom.name}_set');
  }

  final _$imageBase64Atom = Atom(name: '_PlaceFormStore.imageBase64');

  @override
  String get imageBase64 {
    _$imageBase64Atom.context.enforceReadPolicy(_$imageBase64Atom);
    _$imageBase64Atom.reportObserved();
    return super.imageBase64;
  }

  @override
  set imageBase64(String value) {
    _$imageBase64Atom.context.conditionallyRunInAction(() {
      super.imageBase64 = value;
      _$imageBase64Atom.reportChanged();
    }, _$imageBase64Atom, name: '${_$imageBase64Atom.name}_set');
  }

  final _$rateAtom = Atom(name: '_PlaceFormStore.rate');

  @override
  int get rate {
    _$rateAtom.context.enforceReadPolicy(_$rateAtom);
    _$rateAtom.reportObserved();
    return super.rate;
  }

  @override
  set rate(int value) {
    _$rateAtom.context.conditionallyRunInAction(() {
      super.rate = value;
      _$rateAtom.reportChanged();
    }, _$rateAtom, name: '${_$rateAtom.name}_set');
  }

  final _$_PlaceFormStoreActionController =
      ActionController(name: '_PlaceFormStore');

  @override
  dynamic createPlace() {
    final _$actionInfo = _$_PlaceFormStoreActionController.startAction();
    try {
      return super.createPlace();
    } finally {
      _$_PlaceFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'name: ${name.toString()},type: ${type.toString()},location: ${location.toString()},imageFile: ${imageFile.toString()},imageBase64: ${imageBase64.toString()},rate: ${rate.toString()}';
    return '{$string}';
  }
}
