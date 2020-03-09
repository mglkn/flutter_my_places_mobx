import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../store/stores.dart';
import '../../screens/screens.dart';

class AddressInput extends StatefulWidget {
  final placeFormStore = Modular.get<PlaceFormStore>();

  @override
  _AddressInputState createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  TextEditingController _controller;
  ReactionDisposer locationDisposer;
  ReactionDisposer addressOfflineDisposer;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.placeFormStore.address);

    var _reaction =
        (_) => _controller?.text = widget.placeFormStore.address ?? '';

    locationDisposer =
        reaction((_) => widget.placeFormStore.location, _reaction);
    addressOfflineDisposer =
        reaction((_) => widget.placeFormStore.addressOffline, _reaction);

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
                contentPadding: EdgeInsets.only(left: 10.0, right: 40.0),
              ),
            ),
            widget.placeFormStore.isInternetConnected
                ? _MapSelectorButton()
                : Container(),
            widget.placeFormStore.locationError != null &&
                    widget.placeFormStore.locationError.length > 0
                ? _ErrorMessage(
                    widget.placeFormStore.locationError ?? '',
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class _MapSelectorButton extends StatelessWidget {
  final placeFormStore = Modular.get<PlaceFormStore>();

  Future<void> _navigateToMapSelectorScreen(BuildContext context) async {
    final Address location = await Navigator.of(context).push(
      MaterialPageRoute<Address>(
        builder: (_) => MapSelectorScreen(),
      ),
    );

    if (location == null) return;

    placeFormStore.location = location;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(Icons.location_on),
        onPressed: () => _navigateToMapSelectorScreen(context),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;

  _ErrorMessage(this.message) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65.0,
      child: Align(
        alignment: Alignment(0.0, 1.0),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.red,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
