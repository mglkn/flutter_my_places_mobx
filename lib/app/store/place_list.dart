import 'package:mobx/mobx.dart';

part 'place_list.g.dart';

class PlaceListStore = _PlaceListStore with _$PlaceListStore;

abstract class _PlaceListStore with Store {
  @observable
  bool isDismissing = false;
}
