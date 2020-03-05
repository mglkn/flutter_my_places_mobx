import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobx/mobx.dart';

import '../../store/place_form.dart';
import 'widgets/widgets.dart';
import '../../data/db.dart';
import 'screens.dart';

class PlaceFormScreen extends StatefulWidget {
  static String routeName = '/place_form';
  final Place place;

  PlaceFormScreen({this.place});

  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  @override
  void initState() {
    Modular.get<PlaceFormStore>().init(widget.place);
    super.initState();
  }

  void _focusReset(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<PlaceFormStore>();

    return Scaffold(
      appBar: _appBarBuild(store),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        icon: Icon(Icons.add, color: Colors.black),
        label: Text('Save', style: TextStyle(color: Colors.black)),
        onPressed: () async {
          await store.savePlace();
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _focusReset(context),
          child: PlaceForm(),
        ),
      ),
    );
  }

  _appBarBuild(PlaceFormStore store) {
    return AppBar(
      title: Observer(
        builder: (_) => Text(
          store.place != null ? store.place.name : 'New Place',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[100],
      iconTheme: IconThemeData(color: Colors.grey[700]),
      elevation: 0.0,
    );
  }
}

class PlaceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageSelector(),
          NameInput(),
          TypeInput(),
          AddressInput(),
          const SizedBox(height: 20.0),
          RatingInput(),
        ],
      ),
    );
  }
}

class NameInput extends StatefulWidget {
  @override
  _NameInputState createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  TextEditingController _controller;

  @override
  void initState() {
    final store = Modular.get<PlaceFormStore>();
    _controller = TextEditingController(text: store.name);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<PlaceFormStore>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        onChanged: (newValue) => store.name = newValue,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: "Name",
        ),
      ),
    );
  }
}

class TypeInput extends StatefulWidget {
  @override
  _TypeInputState createState() => _TypeInputState();
}

class _TypeInputState extends State<TypeInput> {
  TextEditingController _controller;

  @override
  void initState() {
    final store = Modular.get<PlaceFormStore>();
    _controller = TextEditingController(text: store.type);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<PlaceFormStore>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        onChanged: (newValue) => store.type = newValue,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: "Type",
        ),
      ),
    );
  }
}

class AddressInput extends StatefulWidget {
  @override
  _AddressInputState createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  TextEditingController _controller;
  ReactionDisposer locationDisposer;
  ReactionDisposer addressOfflineDisposer;

  @override
  void initState() {
    final store = Modular.get<PlaceFormStore>();
    _controller = TextEditingController(text: store.address);

    var _reaction = (_) => _controller?.text = store.address ?? '';

    locationDisposer = reaction((_) => store.location, _reaction);
    addressOfflineDisposer = reaction((_) => store.addressOffline, _reaction);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    locationDisposer();
    addressOfflineDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<PlaceFormStore>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Observer(
        builder: (_) => Stack(
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              enabled: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: "Address",
                errorText: store.locationError,
              ),
            ),
            store.isInternetConnected
                ? Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () async {
                        final Address location = await Navigator.of(context)
                            .pushNamed(MapScreen.routeName);

                        if (location == null) return;

                        store.location = location;
                      },
                    ),
                  )
                : Container(),
            store.locationError != null && store.locationError.length > 0
                ? Container(
                    width: double.infinity,
                    height: 65.0,
                    child: Align(
                      alignment: Alignment(0.0, 1.0),
                      child: Text(
                        store.locationError ?? '',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class RatingInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Modular.get<PlaceFormStore>();

    return RatingBar(
      initialRating: store.rate?.toDouble() ?? 0,
      minRating: 0,
      itemCount: 5,
      allowHalfRating: false,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.black45,
      ),
      direction: Axis.horizontal,
      onRatingUpdate: (rating) {
        store.rate = rating.toInt();
      },
      itemSize: 35.0,
      unratedColor: Colors.grey[400],
      glow: false,
      // ignoreGestures: true,
    );
  }
}
