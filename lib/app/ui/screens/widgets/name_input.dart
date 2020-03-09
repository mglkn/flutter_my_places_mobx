import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../store/stores.dart';

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
      child: Observer(
        builder: (_) => TextField(
          controller: _controller,
          onChanged: (newValue) => store.name = newValue,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: "Name",
            errorText: store.nameFieldError,
          ),
        ),
      ),
    );
  }
}
