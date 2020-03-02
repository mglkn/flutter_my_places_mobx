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

  final _$imageAtom = Atom(name: '_PlaceFormStore.image');

  @override
  File get image {
    _$imageAtom.context.enforceReadPolicy(_$imageAtom);
    _$imageAtom.reportObserved();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.context.conditionallyRunInAction(() {
      super.image = value;
      _$imageAtom.reportChanged();
    }, _$imageAtom, name: '${_$imageAtom.name}_set');
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
        'name: ${name.toString()},type: ${type.toString()},location: ${location.toString()},image: ${image.toString()},rate: ${rate.toString()}';
    return '{$string}';
  }
}
