import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart' show StreamGroup;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_places/app/ui/screens/screens.dart';

import '../../data/db_repository.dart';
import '../../data/db.dart';
import 'place_form_screen.dart';

class PlacesListScreen extends StatefulWidget {
  static String routeName = '/';

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 3.0,
        onPressed: () {
          Modular.to.pushNamed(PlaceFormScreen.routeName, arguments: null);
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
      leading: AppBarLeading(
        order: order,
        toggleOrder: _toggleOrder,
      ),
      elevation: 0.0,
    );
  }

  _toggleOrder() {
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

class DismissibleWrapper extends StatefulWidget {
  final Widget child;
  final Place place;
  final Key key;
  final repo = Modular.get<DbDataRepository>();
  final deleteDelay = const Duration(milliseconds: 3000);
  final showSnackBarDelay = const Duration(milliseconds: 2700);

  DismissibleWrapper({this.key, this.child, this.place});

  @override
  _DismissibleWrapperState createState() => _DismissibleWrapperState();
}

class _DismissibleWrapperState extends State<DismissibleWrapper> {
  StreamController streamControllerCancel;
  StreamController streamControllerDone;
  StreamSubscription resultStream;

  void _closeStreams() {
    resultStream?.cancel();
    streamControllerCancel?.close();
    streamControllerDone?.close();
  }

  // Create two streams (done and cancel), merge them and
  // evaluate merged stream as Future.
  // `Done` stream with delay and pass `true` value.
  // `Cancel` stream pass `false` and can called
  // through `streamControllerCancel.sink.add(null)`
  Future<bool> _onDismissed(_) async {
    _closeStreams();

    streamControllerCancel = StreamController<bool>();
    streamControllerDone = StreamController<bool>();

    final streamCancel = streamControllerCancel.stream.map<bool>((_) => false);
    final streamDone = streamControllerDone.stream.asyncMap<bool>((_) async {
      await Future.delayed(widget.deleteDelay);
      return true;
    });

    bool resultDesision;
    resultStream = StreamGroup.merge<bool>([streamDone, streamCancel])
        .take(1)
        .asBroadcastStream()
        .listen(
      (bool desision) {
        resultDesision = desision;
      },
    );

    _showCancelSnackBar();

    streamControllerDone.sink.add(null);

    await resultStream.asFuture();

    if (resultDesision) {
      await widget.repo.removePlace(widget.place);
    }

    return resultDesision;
  }

  _showCancelSnackBar() {
    final snackbar = SnackBar(
      duration: widget.showSnackBarDelay,
      content: Text('Are you shure?'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          streamControllerCancel.sink.add(null);
        },
      ),
    );

    Scaffold.of(context).showSnackBar(snackbar);
  }

  @override
  void dispose() {
    _closeStreams();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: _onDismissed,
      key: widget.key,
      child: widget.child,
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
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border(
            top: BorderSide(
              color: Colors.grey[300],
              width: 2.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TileAvatar(place.image),
            Expanded(
              child: TileContent(place),
            ),
            TileRate(place.rate),
          ],
        ),
      ),
    );
  }
}

class TileAvatar extends StatelessWidget {
  final String image;

  TileAvatar(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 30.0,
        child: ClipOval(
          child: AspectRatio(
            aspectRatio: 1,
            child: image != null
                ? Image.memory(base64Decode(image), fit: BoxFit.fitHeight)
                : Image.asset('assets/images/selectImagePlaceholder.png',
                    fit: BoxFit.fitHeight),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}

class TileContent extends StatelessWidget {
  final Place place;

  TileContent(this.place);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(place.name, style: TextStyle(fontSize: 20.0)),
          Text(place.type, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}

class TileRate extends StatelessWidget {
  final int rate;

  TileRate(this.rate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: RatingBar(
        initialRating: rate?.toDouble() ?? 0,
        minRating: 0,
        itemCount: 5,
        allowHalfRating: false,
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.black45,
        ),
        direction: Axis.horizontal,
        itemSize: 15.0,
        unratedColor: Colors.grey[400],
        glow: false,
        ignoreGestures: true,
        onRatingUpdate: (_) {},
      ),
    );
  }
}
