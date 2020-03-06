// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_form.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceFormStore on _PlaceFormStore, Store {
  Computed<String> _$addressComputed;

  @override
  String get address =>
      (_$addressComputed ??= Computed<String>(() => super.address)).value;

  final _$_placeAtom = Atom(name: '_PlaceFormStore._place');

  @override
  dynamic get _place {
    _$_placeAtom.context.enforceReadPolicy(_$_placeAtom);
    _$_placeAtom.reportObserved();
    return super._place;
  }

  @override
  set _place(dynamic value) {
    _$_placeAtom.context.conditionallyRunInAction(() {
      super._place = value;
      _$_placeAtom.reportChanged();
    }, _$_placeAtom, name: '${_$_placeAtom.name}_set');
  }

  final _$isInternetConnectedAtom =
      Atom(name: '_PlaceFormStore.isInternetConnected');

  @override
  bool get isInternetConnected {
    _$isInternetConnectedAtom.context
        .enforceReadPolicy(_$isInternetConnectedAtom);
    _$isInternetConnectedAtom.reportObserved();
    return super.isInternetConnected;
  }

  @override
  set isInternetConnected(bool value) {
    _$isInternetConnectedAtom.context.conditionallyRunInAction(() {
      super.isInternetConnected = value;
      _$isInternetConnectedAtom.reportChanged();
    }, _$isInternetConnectedAtom,
        name: '${_$isInternetConnectedAtom.name}_set');
  }

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

  final _$addressOfflineAtom = Atom(name: '_PlaceFormStore.addressOffline');

  @override
  String get addressOffline {
    _$addressOfflineAtom.context.enforceReadPolicy(_$addressOfflineAtom);
    _$addressOfflineAtom.reportObserved();
    return super.addressOffline;
  }

  @override
  set addressOffline(String value) {
    _$addressOfflineAtom.context.conditionallyRunInAction(() {
      super.addressOffline = value;
      _$addressOfflineAtom.reportChanged();
    }, _$addressOfflineAtom, name: '${_$addressOfflineAtom.name}_set');
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

  final _$locationErrorAtom = Atom(name: '_PlaceFormStore.locationError');

  @override
  String get locationError {
    _$locationErrorAtom.context.enforceReadPolicy(_$locationErrorAtom);
    _$locationErrorAtom.reportObserved();
    return super.locationError;
  }

  @override
  set locationError(String value) {
    _$locationErrorAtom.context.conditionallyRunInAction(() {
      super.locationError = value;
      _$locationErrorAtom.reportChanged();
    }, _$locationErrorAtom, name: '${_$locationErrorAtom.name}_set');
  }

  final _$nameFieldErrorAtom = Atom(name: '_PlaceFormStore.nameFieldError');

  @override
  String get nameFieldError {
    _$nameFieldErrorAtom.context.enforceReadPolicy(_$nameFieldErrorAtom);
    _$nameFieldErrorAtom.reportObserved();
    return super.nameFieldError;
  }

  @override
  set nameFieldError(String value) {
    _$nameFieldErrorAtom.context.conditionallyRunInAction(() {
      super.nameFieldError = value;
      _$nameFieldErrorAtom.reportChanged();
    }, _$nameFieldErrorAtom, name: '${_$nameFieldErrorAtom.name}_set');
  }

  final _$typeFieldErrorAtom = Atom(name: '_PlaceFormStore.typeFieldError');

  @override
  String get typeFieldError {
    _$typeFieldErrorAtom.context.enforceReadPolicy(_$typeFieldErrorAtom);
    _$typeFieldErrorAtom.reportObserved();
    return super.typeFieldError;
  }

  @override
  set typeFieldError(String value) {
    _$typeFieldErrorAtom.context.conditionallyRunInAction(() {
      super.typeFieldError = value;
      _$typeFieldErrorAtom.reportChanged();
    }, _$typeFieldErrorAtom, name: '${_$typeFieldErrorAtom.name}_set');
  }

  final _$savePlaceAsyncAction = AsyncAction('savePlace');

  @override
  Future<bool> savePlace() {
    return _$savePlaceAsyncAction.run(() => super.savePlace());
  }

  final _$_PlaceFormStoreActionController =
      ActionController(name: '_PlaceFormStore');

  @override
  void checkValidation() {
    final _$actionInfo = _$_PlaceFormStoreActionController.startAction();
    try {
      return super.checkValidation();
    } finally {
      _$_PlaceFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isInternetConnected: ${isInternetConnected.toString()},name: ${name.toString()},type: ${type.toString()},location: ${location.toString()},addressOffline: ${addressOffline.toString()},imageFile: ${imageFile.toString()},imageBase64: ${imageBase64.toString()},rate: ${rate.toString()},locationError: ${locationError.toString()},nameFieldError: ${nameFieldError.toString()},typeFieldError: ${typeFieldError.toString()},address: ${address.toString()}';
    return '{$string}';
  }
}
