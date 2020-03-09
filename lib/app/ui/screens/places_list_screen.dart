import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/db_repository.dart';
import '../../data/db.dart';
import 'screens.dart';
import '../../store/stores.dart';
import 'widgets/widgets.dart';

class PlacesListScreen extends StatefulWidget {
  static String routeName = '/';
  final placeListStore = Modular.get<PlaceListStore>();

  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  EPlaceOrder order;

  @override
  void initState() {
    order = EPlaceOrder.DESC;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: SafeArea(
        child: PlacesList(order),
      ),
      floatingActionButton: Observer(
        builder: (_) => widget.placeListStore.isDismissing
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
      leading: AppBarLeading(
        order: order,
        toggleOrder: _toggleOrder,
      ),
      elevation: 0.0,
    );
  }

  _toggleOrder() {
    if (widget.placeListStore.isDismissing) return;
    setState(() {
      order = order == EPlaceOrder.ASC ? EPlaceOrder.DESC : EPlaceOrder.ASC;
    });
  }
}

typedef void ToggleOrder();

class AppBarLeading extends StatelessWidget {
  final EPlaceOrder order;
  final ToggleOrder toggleOrder;

  AppBarLeading({this.order, this.toggleOrder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: toggleOrder,
        child: order == EPlaceOrder.DESC
            ? Icon(Icons.arrow_downward, color: Colors.grey[600])
            : Icon(Icons.arrow_upward, color: Colors.grey[600]));
  }
}

class PlacesList extends StatelessWidget {
  final EPlaceOrder order;
  final repo = Modular.get<DbDataRepository>();

  PlacesList(this.order);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Place>>(
      initialData: [],
      stream: repo.watchPlaces(order: order),
      builder: (_, AsyncSnapshot<List<Place>> places) {
        return ListView.builder(
          itemCount: places.data.length,
          itemBuilder: (_, int index) => DismissibleWrapper(
            key: ObjectKey(places.data[index]),
            child: PlaceTile(places.data[index]),
            place: places.data[index],
          ),
        );
      },
    );
  }
}
