import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../store/place_form.dart';

class ImageSelector extends StatelessWidget {
  final PlaceFormStore _store;

  ImageSelector() : _store = Modular.get<PlaceFormStore>();

  Future<void> _selectImage(ImageSource source) async {
    final File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;

    _store.imageFile = image;
  }

  _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        child: new Wrap(
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.image),
                title: new Text('Photo archive'),
                onTap: () async {
                  await _selectImage(ImageSource.gallery);
                  Navigator.pop(context);
                }),
            new ListTile(
              leading: new Icon(Icons.camera),
              title: new Text('Camera'),
              onTap: () async {
                await _selectImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _imageTapHandler(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (currentFocus.hasFocus) {
      currentFocus.unfocus();
      return;
    }

    _showModalBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _imageTapHandler(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        width: double.infinity,
        height: 200.0,
        color: Colors.grey[200],
        child: Observer(
          builder: (_) => _store.imageFile != null
              ? Image.asset(
                  _store.imageFile.path,
                  fit: BoxFit.fitWidth,
                )
              : _store.imageBase64 != null
                  ? Image.memory(
                      base64Decode(_store.imageBase64),
                      fit: BoxFit.fitWidth,
                    )
                  : Image.asset(
                      'assets/images/selectImagePlaceholder.png',
                      fit: BoxFit.fitHeight,
                    ),
        ),
      ),
    );
  }
}
