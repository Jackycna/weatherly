import 'package:geolocator/geolocator.dart';

class Location {
  late double lattitude;
  late double longitute;
  Future<void> getCutrrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lattitude = position.latitude;
      longitute = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
