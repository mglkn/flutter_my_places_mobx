import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

// i don't use Directions API becouse it requires billing enabled;
// TODO: instead this screen open google maps with requires path;
class MapPathScreen extends StatefulWidget {
  final Coordinates destination;

  MapPathScreen(this.destination) : assert(destination != null);

  @override
  _MapPathScreenState createState() => _MapPathScreenState();
}

class _MapPathScreenState extends State<MapPathScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  LatLng currentLocation;
  String error;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Position currentPosition;
    try {
      currentPosition = await Geolocator().getCurrentPosition();
    } catch (e) {
      error =
          'Error occured with get current location. Try reload app and check internet connection.';
    }

    if (currentPosition == null) return;

    final _currentLocation =
        LatLng(currentPosition.latitude, currentPosition.longitude);

    final destination =
        LatLng(widget.destination.latitude, widget.destination.longitude);

    setState(() {
      currentLocation = _currentLocation;

      final polyline = Polyline(
        polylineId: PolylineId('__polyline__'),
        visible: true,
        points: [
          currentLocation,
          destination,
        ],
        color: Colors.blue,
      );

      _polylines = {polyline};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: error != null
          ? ErrorMessage(error)
          : currentLocation == null
              ? ProgressIndicator()
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation.latitude, currentLocation.longitude),
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
