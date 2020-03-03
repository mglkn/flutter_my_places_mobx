import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'map_screen.dart';
import '../../store/place_form.dart';
import 'widgets/widgets.dart';

class PlaceFormScreen extends StatelessWidget {
  static String routeName = '/place_form';

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
      appBar: _appBarBuild(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        icon: Icon(Icons.add, color: Colors.black),
        label: Text('Save', style: TextStyle(color: Colors.black)),
        onPressed: () {
          store.createPlace();
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

  _appBarBuild() {
    return AppBar(
      title: Text(
        'New Place',
        style: TextStyle(color: Colors.grey[700]),
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
    _controller = TextEditingController();
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
        onChanged: (newValue) => store.name = _controller.value.text,
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
    _controller = TextEditingController();
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
        onChanged: (newValue) => store.type = _controller.value.text,
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

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          TextField(
            controller: _controller,
            keyboardType: TextInputType.text,
            enabled: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: "Address",
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Modular.to.pushNamed(MapScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
