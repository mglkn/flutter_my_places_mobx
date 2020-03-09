import 'package:geocoder/geocoder.dart';

abstract class GeoService {
  Future<Address> getAddress({double latitude, double longitude});
  String getShortAddress(Address location);

  factory GeoService.instance() => _GeoService();
}

class _GeoService implements GeoService {
  _GeoService._internal();
  static final _GeoService _instance = _GeoService._internal();
  factory _GeoService() => _instance;

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
}
