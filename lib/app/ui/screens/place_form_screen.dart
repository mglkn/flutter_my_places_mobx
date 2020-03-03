import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'map_screen.dart';

class PlaceFormScreen extends StatelessWidget {
  static String routeName = '/place_form';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: PlaceForm(),
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

class ImageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('pick image');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        width: double.infinity,
        height: 200.0,
        color: Colors.grey[200],
        child: Image.asset(
          'assets/images/selectImagePlaceholder.png',
          fit: BoxFit.fitHeight,
        ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
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
