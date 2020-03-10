// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceListStore on _PlaceListStore, Store {
  final _$isDismissingAtom = Atom(name: '_PlaceListStore.isDismissing');

  @override
  bool get isDismissing {
    _$isDismissingAtom.context.enforceReadPolicy(_$isDismissingAtom);
    _$isDismissingAtom.reportObserved();
    return super.isDismissing;
  }

  @override
  set isDismissing(bool value) {
    _$isDismissingAtom.context.conditionallyRunInAction(() {
      super.isDismissing = value;
      _$isDismissingAtom.reportChanged();
    }, _$isDismissingAtom, name: '${_$isDismissingAtom.name}_set');
  }

  final _$_placesAtom = Atom(name: '_PlaceListStore._places');

  @override
  ObservableList<dynamic> get _places {
    _$_placesAtom.context.enforceReadPolicy(_$_placesAtom);
    _$_placesAtom.reportObserved();
    return super._places;
  }

  @override
  set _places(ObservableList<dynamic> value) {
    _$_placesAtom.context.conditionallyRunInAction(() {
      super._places = value;
      _$_placesAtom.reportChanged();
    }, _$_placesAtom, name: '${_$_placesAtom.name}_set');
  }

  final _$orderAtom = Atom(name: '_PlaceListStore.order');

  @override
  EPlaceOrder get order {
    _$orderAtom.context.enforceReadPolicy(_$orderAtom);
    _$orderAtom.reportObserved();
    return super.order;
  }

  @override
  set order(EPlaceOrder value) {
    _$orderAtom.context.conditionallyRunInAction(() {
      super.order = value;
      _$orderAtom.reportChanged();
    }, _$orderAtom, name: '${_$orderAtom.name}_set');
  }

  final _$_PlaceListStoreActionController =
      ActionController(name: '_PlaceListStore');

  @override
  dynamic toggleOrder() {
    final _$actionInfo = _$_PlaceListStoreActionController.startAction();
    try {
      return super.toggleOrder();
    } finally {
      _$_PlaceListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isDismissing: ${isDismissing.toString()},order: ${order.toString()}';
    return '{$string}';
  }
}
