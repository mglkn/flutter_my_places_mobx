import 'dart:async';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../services/geo.dart';
import 'widgets/widgets.dart';

class MapSelectorScreen extends StatefulWidget {
  final geoService = Modular.get<GeoService>();

  @override
  _MapSelectorScreenState createState() => _MapSelectorScreenState();
}

class _MapSelectorScreenState extends State<MapSelectorScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = Set();
  Address _location;
  String _error;
  bool _isGeocoderRequest = false;
  LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  _setCurrentLocation() async {
    try {
      final _location = await widget.geoService.getCurrentLocation();

      setState(() {
        _currentLocation = _location;
      });

      if (_currentLocation == null) {
        setState(() {
          _error =
              'I can`t get your current position, try reload app or check permission your app.';
        });
      }
    } catch (error) {
      setState(() {
        _error = error.toString();
      });
    }
  }

  _selectPoint(LatLng latLng) async {
    if (mounted == false) return;
    _error = null;

    setState(() {
      _isGeocoderRequest = true;
      _markers = Set()
        ..add(
          Marker(
            markerId: MarkerId('${latLng.hashCode}'),
            position: latLng,
            draggable: false,
          ),
        );
    });

    Address address;
    try {
      address = await widget.geoService.getAddress(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      );
    } on PlatformException catch (_) {
      if (mounted == false) return;

      setState(() {
        _error = 'Some internet error occured, please reenter in map page';
        _isGeocoderRequest = false;
      });
    } catch (_) {
      if (mounted == false) return;

      setState(() {
        _error = 'Some error occured, please reenter in map page';
        _isGeocoderRequest = false;
      });
    }

    if (address != null) {
      setState(
        () {
          _location = address;
          _isGeocoderRequest = false;
        },
      );
    }
  }

  String shortAddress() {
    return _location != null
        ? widget.geoService.getShortAddress(_location)
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      floatingActionButton: _location == null && !_isGeocoderRequest
          ? null
          : _isGeocoderRequest
              ? CircularProgressIndicator()
              : FloatingActionButton.extended(
                  label: Text('DONE'),
                  icon: Icon(Icons.done),
                  elevation: 3.0,
                  onPressed: () {
                    Navigator.of(context).pop(_location);
                  },
                ),
      body: _error != null
          ? MapErrorMessage(_error)
          : Stack(
              children: <Widget>[
                _currentLocation != null
                    ? GoogleMap(
                        onTap: _isGeocoderRequest ? null : _selectPoint,
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: _currentLocation,
                          zoom: 16.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        markers: _markers,
                      )
                    : ProgressIndicator(),
                _location != null ? _Message(shortAddress()) : Container(),
                _error != null && _error.length > 0
                    ? _Message(_error)
                    : Container(),
              ],
            ),
    );
  }

  _appBarBuild() {
    return AppBar(
      title: Text(
        'Map',
        style: TextStyle(color: Colors.grey[700]),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[100],
      iconTheme: IconThemeData(color: Colors.grey[700]),
      elevation: 0.0,
    );
  }
}

class _Message extends StatelessWidget {
  final String text;
  _Message(this.text) : assert(text != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 50.0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
