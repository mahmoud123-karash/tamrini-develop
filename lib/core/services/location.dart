import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';

Future<String> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  String lang = Intl.getCurrentLocale();
  bool isConnected = await InternetConnectionChecker().hasConnection;
  if (!isConnected) {
    return lang == 'en'
        ? 'Please check the internet connection'
        : 'من فضلك قم بالتحقق من الاتصال';
  }

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return lang == 'en'
        ? 'Please enble location sevice'
        : 'من فضلك قم بتفعيل خدمة الموقع';
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    return lang == 'en'
        ? 'Please enble location permission'
        : 'من فضلك قم بالسماح للوصول للموقع';
  }
  if (permission == LocationPermission.deniedForever) {
    return lang == 'en'
        ? 'Please enble location permission'
        : 'من فضلك قم بالسماح للوصول للموقع';
  }

  return '';
}

Future<double> getDistance({
  required double endLatitude,
  required double endLongitude,
  required bool update,
}) async {
  double lat = CacheHelper.getData(key: 'lat') ?? 0;
  double long = CacheHelper.getData(key: 'long') ?? 0;
  double distance = 0;
  if (!update && lat != 0) {
    distance = Geolocator.distanceBetween(
          lat,
          long,
          endLatitude,
          endLongitude,
        ) /
        1000;
  } else {
    Position currentPosition = await Geolocator.getCurrentPosition();
    saveLat(currentPosition.latitude);
    saveLong(currentPosition.longitude);
    distance = Geolocator.distanceBetween(
          currentPosition.latitude,
          currentPosition.longitude,
          endLatitude,
          endLongitude,
        ) /
        1000;
  }
  return distance;
}

Future<String> getAddress({required GeoPoint location}) async {
  if (!await InternetConnectionChecker().hasConnection) {
    return Intl.getCurrentLocale() == 'en' ? 'Bagdad ElErak' : 'بغداد العراق';
  } else {
    var result = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
      localeIdentifier: Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    );
    if (result.isNotEmpty) {
      String country = result.first.country ?? '';
      String city = result.first.locality ?? '';
      String subAdministrativeArea = result.first.subAdministrativeArea ?? '';

      return '$country $city $subAdministrativeArea';
    } else {
      return '';
    }
  }
}
