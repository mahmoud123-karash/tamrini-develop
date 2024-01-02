import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/firebase_stuff/firestore.dart';
import 'package:tamrini/model/nutritional.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../utils/helper_functions.dart';

class NutritionalValueProvider extends ChangeNotifier {
  double protein = 0.0;
  double fat = 0.0;
  double carbs = 0.0;
  double calories = 0.0;
  List<Nutritious> _nutritiousList = [], nutritiousList = [];
  Nutritious nutritiousAdded = Nutritious(
      title: "اختر الوجبة",
      calories: 0.0,
      proteins: 0.0,
      fats: 0.0,
      carbs: 0.0,
      id: "id");
  bool isInitiated = false;

  calculate({required Nutritious nutritious, required int weight}) {
    protein = nutritious.proteins * weight;
    fat = nutritious.fats * weight;
    carbs = nutritious.carbs * weight;
    calories = nutritious.calories * weight;
    notifyListeners();
  }

  search(String query) {
    if (query.isEmpty) {
      nutritiousList = _nutritiousList;
    } else {
      nutritiousList = _nutritiousList
          .where(
            (element) => HelperFunctions.matchesSearch(
              query.toLowerCase().split(" "),
              element.title,
            ),
          )
          .toList();
    }
    notifyListeners();
  }

  reset() {
    protein = 0.0;
    fat = 0.0;
    carbs = 0.0;
    calories = 0.0;
    notifyListeners();
  }

  initiate() {
    if (isInitiated == true) _nutritiousList.clear();

    _nutritiousList.add(nutritiousAdded);

    try {
      FirebaseFirestore.instance
          .collection('nutritious')
          .doc('data')
          .collection('data')
          .orderBy('title', descending: false)
          .getSavy()
          .then((value) {
        for (var element in value.docs) {
          _nutritiousList.add(Nutritious.fromJson(
              element.data() as Map<String, dynamic>, element.id));
        }
        nutritiousList = _nutritiousList;

        print(nutritiousList.length);
      });
      isInitiated = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addNewNutritious(Nutritious nutritious) async {
    try {
      if (nutritious.proteins < 0.0 ||
          nutritious.fats < 0.0 ||
          nutritious.carbs < 0.0 ||
          nutritious.calories < 0.0) {
        showDialog(
            context: navigationKey.currentContext!,
            builder: (context) {
              return AlertDialog(
                title: const Text('حطأ'),
                content: const Text('الرجاء ادخال القيم بشكل صحيح'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'))
                ],
              );
            });
        return;
      }
      await FirebaseFirestore.instance
          .collection('nutritious')
          .doc('data')
          .collection('data')
          .add(nutritious.toJson())
          .then((value) => nutritious.id = value.id);
      nutritiousList.add(nutritious);
      notifyListeners();
      AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'تمت الاضافة بنجاح',
          desc: 'تمت اضافة الوجبة بنجاح',
          btnOkOnPress: () {
            pop();
          }).show();
    } catch (e) {
      print(e);
    }
  }

  deleteNutritious(Nutritious nutritious) async {
    try {
      await FirebaseFirestore.instance
          .collection('nutritious')
          .doc('data')
          .collection('data')
          .doc(nutritious.id)
          .delete();

      AwesomeDialog(
              context: navigationKey.currentContext!,
              dialogType: DialogType.SUCCES,
              animType: AnimType.BOTTOMSLIDE,
              title: 'تم الحذف بنجاح',
              desc: 'تم حذف الوجبة بنجاح',
              btnOkOnPress: () {
                // pop();
              })
          .show();

      nutritiousList.removeWhere((element) => nutritious.id == element.id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  updateNutritious(Nutritious nutritious) async {
    try {
      await FirebaseFirestore.instance
          .collection('nutritious')
          .doc('data')
          .collection('data')
          .doc(nutritious.id)
          .update(nutritious.toJson());

      nutritiousList.removeWhere((element) => nutritious.id == element.id);
      nutritiousList.add(nutritious);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
