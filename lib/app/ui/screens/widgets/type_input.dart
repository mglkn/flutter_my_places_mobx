import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../store/stores.dart';

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
      child: Observer(
        builder: (_) => TextField(
          controller: _controller,
          onChanged: (newValue) => store.type = newValue,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: "Type",
            errorText: store.typeFieldError,
          ),
        ),
      ),
    );
  }
}
