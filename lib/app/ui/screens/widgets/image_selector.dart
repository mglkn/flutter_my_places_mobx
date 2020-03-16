import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_places/app/services/image.dart';

import '../../../store/place_form.dart';
import '../../screens/screens.dart';

class ImageSelector extends StatelessWidget {
  final PlaceFormStore placeFormStore = Modular.get<PlaceFormStore>();
  final ImageService imageService = Modular.get<ImageService>();

  _showSnackBar({String message, BuildContext context}) {
    final snackbar = SnackBar(
      content: Text(message),
      action: null,
    );

    Scaffold.of(context).showSnackBar(snackbar);
  }

  Future<void> _selectImage({ImageSource source, BuildContext context}) async {
    File image;
    try {
      image = await imageService.pickImage(source);
    } on PlatformException catch (error) {
      if (error.code == 'photo_access_denied') {
        _showSnackBar(
          message: 'You have no permission for photo gallery.',
          context: context,
        );
        return;
      }
      if (error.code == 'camera_access_denied') {
        _showSnackBar(
          message: 'You have no permission for camera.',
          context: context,
        );
        return;
      }

      _showSnackBar(
        message: 'Unknown error. Check your permissions',
        context: context,
      );
    } catch (error) {
      _showSnackBar(
        message: 'Unknown error. Check your permissions',
        context: context,
      );
    }

    if (image == null) return;

    placeFormStore.imageFile = image;
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
                await _selectImage(
                    source: ImageSource.gallery, context: context);
                Navigator.pop(context);
              },
            ),
            new ListTile(
              leading: new Icon(Icons.camera),
              title: new Text('Camera'),
              onTap: () async {
                await _selectImage(
                    source: ImageSource.camera, context: context);
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

    if (currentFocus.hasFocus && !currentFocus.hasPrimaryFocus) {
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
          builder: (_) {
            return Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Hero(
                    tag: 'image_${placeFormStore.place?.id}',
                    child: _getImage(),
                  ),
                ),
                Align(
                  alignment: Alignment(.8, .7),
                  child: placeFormStore.location == null ||
                          placeFormStore.isInternetConnected == false
                      ? Container()
                      : IconButton(
                          icon: Icon(
                            Icons.place,
                            size: 50.0,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            final placeStore = Modular.get<PlaceFormStore>();

                            if (placeStore.location == null) return;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => MapPathScreen(
                                  placeStore.location.coordinates,
                                ),
                              ),
                            );
                          },
                        ),
                ),
                placeFormStore.imageError == null
                    ? Container()
                    : _imageErrorMessage(placeFormStore.imageError)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _imageErrorMessage(String message) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _getImage() {
    return placeFormStore.imageFile != null
        ? Image.file(
            placeFormStore.imageFile,
            fit: BoxFit.fitWidth,
          )
        : Image.asset(
            'assets/images/selectImagePlaceholder.png',
            fit: BoxFit.fitHeight,
          );
  }
}
