import 'package:location/location.dart';

class LocationHelper {
  late double? latitude;
  late double? longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissiongranted;
    LocationData _locationData;

    //Location için servis ayakta mı
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // konum izin kontrolü
    _permissiongranted = await location.hasPermission();
    if (_permissiongranted == PermissionStatus.denied) {
      _permissiongranted = await location.requestPermission();
      if (_permissiongranted != PermissionStatus.granted) {
        return;
      }
    }
    // izinler tamam ise

    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
  }
}
