import 'package:geocoder/geocoder.dart';

abstract class GeocoderService {
  Future<Address> getAddress({double latitude, double longitude});
  String getShortAddress(Address location);

  factory GeocoderService.instance() => _GeocoderService();
}

class _GeocoderService implements GeocoderService {
  _GeocoderService._internal();
  static final _GeocoderService _instance = _GeocoderService._internal();
  factory _GeocoderService() => _instance;

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
