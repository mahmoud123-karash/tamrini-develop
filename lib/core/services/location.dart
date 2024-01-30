import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

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
    return Intl.getCurrentLocale() == 'en' ? 'Iraq Baghdad' : 'بغداد العراق';
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

setLocation(Prediction suggestion, GoogleMapController controller) async {
  var location = await getPlaceMarkFromId(suggestion.placeId ?? '');
  saveLatMap(location.lat ?? 0.0);
  saveLatMap(location.lng ?? 0.0);
  controller.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(location.lat ?? 0.0, location.lng ?? 0.0),
        zoom: 17,
      ),
    ),
  );
}

Future<dynamic> getPlaceMarkFromId(String placeId) async {
  final geocoding =
      GoogleMapsGeocoding(apiKey: "AIzaSyBufaYHAy80nTHvhEjS8ABOwBlSK_3HCnQ");

  final response = await geocoding.searchByPlaceId(placeId);

  final result = response.results[0].geometry.location;
  return result;
}

Future<List<Prediction>> searchLocation(
  BuildContext context,
  String text,
) async {
  List<Prediction> predictionList = [];
  if (text.isNotEmpty) {
    http.Response response = await getLocationData(text);
    var data = jsonDecode(response.body.toString());
    if (data['status'] == 'OK') {
      predictionList = [];
      data['predictions'].forEach(
          (prediction) => predictionList.add(Prediction.fromJson(prediction)));
    } else {}
  }
  return predictionList;
}

Future<http.Response> getLocationData(String text) async {
  http.Response response;

  var apiKey = "AIzaSyBufaYHAy80nTHvhEjS8ABOwBlSK_3HCnQ";
  response = await http.get(Uri.parse(
    'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$text&key=$apiKey',
  ));
  return response;
}
