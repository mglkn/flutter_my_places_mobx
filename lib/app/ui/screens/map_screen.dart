import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class MapScreen extends StatefulWidget {
  static String routeName = '/map';

  static final CameraPosition _kGoogleUstug = CameraPosition(
    target: LatLng(60.767437, 46.307342),
    zoom: 18.4746,
  );

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = Set();
  Address _location;
  String _error;
  bool _isPontSelecting = false;

  _selectPoint(LatLng latLng) async {
    if (mounted == false) return;
    _error = '';

    setState(() {
      _isPontSelecting = true;
    });

    final coordinates = Coordinates(latLng.latitude, latLng.longitude);
    List<Address> addresses = [];

    try {
      addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
    } on PlatformException catch (_) {
      if (mounted == false) return;

      setState(() {
        _error = 'Some internet error occured, please reenter in map page';
        _isPontSelecting = false;
      });
    } catch (_) {
      if (mounted == false) return;

      setState(() {
        _error = 'Some error occured, please reenter in map page';
        _isPontSelecting = false;
      });
    }

    if (addresses.length > 0) {
      var first = addresses.first;
      setState(
        () {
          _location = first;
          _markers = Set()
            ..add(
              Marker(
                markerId: MarkerId('${latLng.hashCode}'),
                position: latLng,
                draggable: false,
              ),
            );
          _isPontSelecting = false;
        },
      );
    }
  }

  String shortAddress() {
    return _location != null
        ? '${_location.locality}, ${_location.thoroughfare}, ${_location.featureName}'
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      floatingActionButton: _location == null || _isPontSelecting
          ? null
          : FloatingActionButton.extended(
              label: Text('DONE'),
              icon: Icon(Icons.done),
              elevation: 3.0,
              onPressed: () {
                Navigator.of(context).pop(_location);
              },
            ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: _isPontSelecting ? null : _selectPoint,
            mapType: MapType.normal,
            initialCameraPosition: MapScreen._kGoogleUstug,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
          ),
          _location != null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50.0,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text(shortAddress()),
                  ),
                )
              : Container(),
          _error != null && _error.length > 0
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50.0,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text(_error),
                  ),
                )
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
