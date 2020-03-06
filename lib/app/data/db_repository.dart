import 'dart:async';

import 'db.dart';

abstract class DbDataRepository {
  Stream<List<Place>> watchPlaces({EPlaceOrder order});
  Future<int> createPlace(Place place);
  Future<bool> updatePlace(Place place);
  Future<int> removePlace(Place place);

  factory DbDataRepository.db() => _DbDataRepository();
}

class _DbDataRepository implements DbDataRepository {
  _DbDataRepository._internal();
  static final _DbDataRepository _instance = _DbDataRepository._internal();
  factory _DbDataRepository() => _instance;

  final AppDatabase _db = AppDatabase();

  @override
  Future<int> createPlace(Place place) {
    return _db.placesDao.create(place);
  }

  @override
  Future<int> removePlace(Place place) {
    return _db.placesDao.remove(place);
  }

  @override
  Future<bool> updatePlace(Place place) {
    return _db.placesDao.modify(place);
  }

  @override
  Stream<List<Place>> watchPlaces({EPlaceOrder order}) {
    return _db.placesDao.watchAll(order: order);
  }
}
