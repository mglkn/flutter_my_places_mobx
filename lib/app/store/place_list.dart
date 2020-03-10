import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../data/db_repository.dart';
import '../data/db.dart';

part 'place_list.g.dart';

class PlaceListStore = _PlaceListStore with _$PlaceListStore;

abstract class _PlaceListStore with Store implements Disposable {
  final DbDataRepository _repo;

  StreamSubscription _placesStream;
  ReactionDisposer _changeOrderReactionDisposer;

  @override
  dispose() {
    _placesStream?.toString();
    _changeOrderReactionDisposer();
  }

  _PlaceListStore(DbDataRepository repo)
      : _repo = repo ?? DbDataRepository.db() {
    setPlacesStream();
    _changeOrderReactionDisposer =
        reaction((_) => order, (_) => setPlacesStream());
  }

  @observable
  bool isDismissing = false;

  @observable
  ObservableList<dynamic> _places = ObservableList<dynamic>();

  List<Place> get places => List<Place>.from(_places.toList());

  @observable
  EPlaceOrder order = EPlaceOrder.DESC;

  @action
  toggleOrder() =>
      order = order == EPlaceOrder.DESC ? EPlaceOrder.ASC : EPlaceOrder.DESC;

  setPlacesStream() {
    _placesStream?.cancel();
    _placesStream = _repo
        .watchPlaces(order: order)
        .listen((List<Place> places) => _places = ObservableList.of(places));
  }
}
