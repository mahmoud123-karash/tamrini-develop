import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tamrini/data/location.dart';
import 'package:tamrini/firebase_stuff/firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/gym.dart';
import '../utils/helper_functions.dart';
import '../utils/widgets/global Widgets.dart';
import 'Upload_Image_provider.dart';

class GymProvider with ChangeNotifier {
  List<Gym> _gyms = [];
  List<Gym> filteredGyms = [];
  bool isLoading = false;
  String? selectedSortBy;
  TextEditingController searchController = TextEditingController();

  List<Gym> get gyms {
    return [..._gyms];
  }

  changeSelectedSortBy(String? value) {
    selectedSortBy = value;
    switch (value) {
      case 'الأقرب':
        sortByDistance(isAscending: true);
        break;
      case 'الأبعد':
        sortByDistance(isAscending: false);
        break;
      case 'الأعلى سعراً':
        sortByPrice(isAscending: false);
        break;
      case 'الأقل سعراً':
        sortByPrice(isAscending: true);
        break;
      default:
        sortByDistance();
    }
  }

  Future<void> fetchAndSetGyms() async {
    isLoading = true;
    try {
      Position location;
      double startLatitude;
      double startLongitude;
      try {
        // ask for permission
        location = await determinePosition();
        startLatitude = location.latitude;
        startLongitude = location.longitude;
      } catch (error) {
        startLatitude = 33.3118944;
        startLongitude = 44.4959932;
        // default location in baghdad
        print(error);
      }

      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .getSavy()
          .then((event) {
        _gyms = event.docs.map((e) {
          var data = e.data() as Map<String, dynamic>;
          GeoPoint endLocation = data['location'];
          double distance = Geolocator.distanceBetween(startLatitude,
                  startLongitude, endLocation.latitude, endLocation.longitude) /
              1000;

          Gym gym =
              Gym.fromJson(e.data() as Map<String, dynamic>, e.id, distance);

          return gym;
        }).toList();

        filteredGyms = [..._gyms];
        isLoading = false;

        sortByDistance();
        // notifyListeners();
      });
    } catch (error) {
      isLoading = false;
      print(error);
    }
  }

  Future<void> addGym(Gym gym) async {
    try {
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .add(gym.toJson())
          .then((value) {
        print('added');
        gym.id = value.id;
        _gyms.add(gym);
        filteredGyms = [..._gyms];
        notifyListeners();
      });
      AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'تمت العملية بنجاح',
          desc: 'تمت إضافة الصالة بنجاح',
          btnOkOnPress: () {
            navigationKey.currentState!.pop();
          }).show();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteGym(String id) async {
    try {
      var data = _gyms.firstWhere((element) => element.id == id).assets;
      FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(id)
          .delete()
          .then((value) async {
        await UploadProvider().deleteAllAssets(data);

        _gyms.removeWhere((element) => element.id == id);
        filteredGyms = [..._gyms];
        AwesomeDialog(
                context: navigationKey.currentContext!,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'تمت العملية بنجاح',
                desc: 'تمت حذف الصالة بنجاح',
                btnOkOnPress: () {})
            .show();
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateGym(Gym gym) async {
    try {
      var data = _gyms.firstWhere((element) => element.id == gym.id).assets;

      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(gym.id)
          .update(gym.toJson());
      log(' ${gym.id}');

      await UploadProvider()
          .deleteOldImages(oldImages: data, newImages: gym.assets);

      AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'تمت العملية بنجاح',
          desc: 'تمت تعديل الصالة بنجاح',
          btnOkOnPress: () {
            pop();
            pop();
          }).show();

      _gyms[_gyms.indexWhere((element) => element.id == gym.id)] = gym;
      filteredGyms = [..._gyms];

      notifyListeners();
    } catch (error) {
      pop();
      AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'حدث خطأ',
          desc: 'حدث خطأ أثناء تعديل الصالة',
          btnOkOnPress: () {
            navigationKey.currentState!.pop();
          }).show();
      print("eroorr$error");
    }
  }

  Future<void> searchGym() async {
    if (searchController.text.isEmpty) {
      filteredGyms = [..._gyms];
      notifyListeners();
      return;
    }

    filteredGyms = _gyms.where((element) {
      return HelperFunctions.matchesSearch(
        searchController.text.toLowerCase().split(" "),
        element.name,
      );
    }).toList();
    notifyListeners();
  }

  clearSearch() {
    searchController.clear();
    filteredGyms = [..._gyms];
  }

  sortByPrice({bool isAscending = true}) {
    filteredGyms.sort((a, b) {
      return a.price.compareTo(b.price);
    });
    if (!isAscending) {
      filteredGyms = filteredGyms.reversed.toList();
    }
    notifyListeners();
  }

  sortByDistance({bool isAscending = true}) async {
    if (await checkPermission()) {
      filteredGyms.sort((a, b) {
        return a.distance.compareTo(b.distance);
      });
      if (!isAscending) {
        filteredGyms = filteredGyms.reversed.toList();
      }

      notifyListeners();
    } else {
      AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'يرجى تمكين خدمات الموقع لاستخدام هذة الخاصية',
          btnOkOnPress: () {
            checkPermission();
          }).show();
    }
  }

  Future<void> openMap(Gym gym) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${gym.location.latitude},${gym.location.longitude}';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
