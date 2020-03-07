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

  @override
  String toString() {
    final string = 'isDismissing: ${isDismissing.toString()}';
    return '{$string}';
  }
}
