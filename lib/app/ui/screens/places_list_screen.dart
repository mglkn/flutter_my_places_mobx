import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../data/db_repository.dart';
import '../../data/db.dart';
import 'place_form_screen.dart';

class PlacesListScreen extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: SafeArea(
        child: PlacesList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
        onPressed: () {
          Modular.to.pushNamed(PlaceFormScreen.routeName);
        },
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
      elevation: 0.0,
    );
  }
}

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repo = Modular.get<DbDataRepository>();

    return StreamBuilder<List<Place>>(
      initialData: [],
      stream: repo.watchPlaces(),
      builder: (_, AsyncSnapshot<List<Place>> places) {
        return ListView.builder(
          itemCount: places.data.length,
          itemBuilder: (_, int index) => PlaceTile(places.data[index]),
        );
      },
    );
  }
}

class PlaceTile extends StatelessWidget {
  final Place place;

  PlaceTile(this.place);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(PlaceFormScreen.routeName, arguments: place);
      },
      child: Text(place.name),
    );
  }
}
