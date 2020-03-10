import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/db.dart';
import 'screens.dart';
import '../../store/stores.dart';
import 'widgets/widgets.dart';

class PlacesListScreen extends StatelessWidget {
  static String routeName = '/';

  final placeListStore = Modular.get<PlaceListStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: SafeArea(
        child: PlacesList(),
      ),
      floatingActionButton: Observer(
        builder: (_) => placeListStore.isDismissing
            ? Container()
            : FloatingActionButton(
                child: Icon(Icons.add),
                elevation: 3.0,
                onPressed: () {
                  Modular.to
                      .pushNamed(PlaceFormScreen.routeName, arguments: null);
                },
              ),
      ),
    );
  }

  _appBarBuild() {
    return AppBar(
      title: Text(
        'My Places',
        style: TextStyle(color: Colors.grey[700]),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[100],
      leading: AppBarLeading(),
      elevation: 0.0,
    );
  }
}

class AppBarLeading extends StatelessWidget {
  final placeListStore = Modular.get<PlaceListStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => placeListStore.toggleOrder(),
      child: Observer(
        builder: (_) => placeListStore.order == EPlaceOrder.DESC
            ? Icon(Icons.arrow_downward, color: Colors.grey[600])
            : Icon(Icons.arrow_upward, color: Colors.grey[600]),
      ),
    );
  }
}

class PlacesList extends StatelessWidget {
  final placeListStore = Modular.get<PlaceListStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        itemCount: placeListStore.places.length,
        itemBuilder: (_, int index) => DismissibleWrapper(
          key: ObjectKey(placeListStore.places[index]),
          child: PlaceTile(placeListStore.places[index]),
          place: placeListStore.places[index],
        ),
      ),
    );
  }
}
