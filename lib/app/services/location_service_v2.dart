import 'package:geolocator/geolocator.dart';

class LocationService {

  // check if the location service is enable on the mobile
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // check if the app has permision to get mobile's location
  Future<LocationPermission> getLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  // Request permission to access the mobile's location
  Future<LocationPermission> requestLocationPermission() async {
    return await Geolocator.requestPermission();
  }

  // Get the user's current location
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await getLocationPermission();
    if (permission == LocationPermission.denied) {
      // If the user has denied permission to access their location, throw an error
      throw Exception('Location permission denied');
    }

    if (permission == LocationPermission.deniedForever) {
      // If the user has permanently denied permission to access their location, open the app settings
      await Geolocator.openAppSettings();
      throw Exception('Location permission  denied');
    }

    // If the user has granted permission to access their location, get their current position
    return await Geolocator.getCurrentPosition();
  }

}
