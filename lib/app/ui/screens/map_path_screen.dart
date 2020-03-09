import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../services/geo.dart';

// i don't use Directions API becouse it requires billing enabled;
// TODO: instead this screen open google maps with requires path;
class MapPathScreen extends StatefulWidget {
  final Coordinates destination;
  final geoService = Modular.get<GeoService>();

  MapPathScreen(this.destination) : assert(destination != null);

  @override
  _MapPathScreenState createState() => _MapPathScreenState();
}

class _MapPathScreenState extends State<MapPathScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  LatLng _currentLocation;
  String _error;

  @override
  void initState() {
    super.initState();
    _setLocations();
  }

  _setLocations() async {
    final destination =
        LatLng(widget.destination.latitude, widget.destination.longitude);
    try {
      final _location = await widget.geoService.getCurrentLocation();

      setState(() {
        _currentLocation = _location;

        final polyline = Polyline(
          polylineId: PolylineId('__polyline__'),
          visible: true,
          points: [
            _currentLocation,
            destination,
          ],
          color: Colors.blue,
        );

        _polylines = {polyline};
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
      });
    }

    if (_currentLocation == null) {
      setState(() {
        _error =
            'I can`t get your current position, try reload app or check permission your app.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: _error != null
          ? ErrorMessage(_error)
          : _currentLocation == null
              ? ProgressIndicator()
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 15.0,
                  ),
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  polylines: _polylines,
                  markers: _markers,
                ),
    );
  }

  _appBarBuild() {
    return AppBar(
      title: Text('Map', style: TextStyle(color: Colors.grey[700])),
      centerTitle: true,
      backgroundColor: Colors.grey[100],
      iconTheme: IconThemeData(color: Colors.grey[700]),
      elevation: 0.0,
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final String message;

  ErrorMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
