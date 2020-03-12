import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeoService {
  Future<Address> getAddress({double latitude, double longitude});
  String getShortAddress(Address location);
  Future<LatLng> getCurrentLocation();

  factory GeoService.instance() => _GeoService();
}

class _GeoService implements GeoService {
  _GeoService._internal();
  static final _GeoService _instance = _GeoService._internal();
  factory _GeoService() => _instance;

  final location = Location();

  @override
  Future<Address> getAddress({double latitude, double longitude}) async {
    final coordinates = Coordinates(latitude, longitude);

    List<Address> addresses = [];

    try {
      addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
    } catch (_) {
      rethrow;
    }

    return addresses.length > 0 ? addresses.first : null;
  }

  @override
  String getShortAddress(Address location) {
    // TODO: fix commas
    return '${location.locality ?? ''}, ${location.thoroughfare ?? ''}, ${location.featureName ?? ''}';
  }

  @override
  Future<LatLng> getCurrentLocation() async {
    try {
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Exception('Geolocation service is not enabled.');
        }
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.DENIED) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.GRANTED) {
          throw Exception('Permission is not granted.');
        }
      }

      print('before');

      // final _locationData = await location.getLocation();
      final _locationData = await Geolocator().getCurrentPosition();

      print('after');

      return LatLng(_locationData.latitude, _locationData.longitude);
    } catch (_) {
      throw Exception('Some platform error try reload screen or app');
    }
  }
}
