import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamrini/utils/cache_helper.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../model/question.dart';
import '../utils/helper_functions.dart';

class QuestionsProvider with ChangeNotifier {
  List<Question> _questions = [], filteredQuestions = [];
  String username = '';
  String name = '';
  bool isLogged = false;
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchQuestions() async {
    try {
      isLoading = true;
      FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .snapshots()
          .listen((event) {
        _questions = event.docs
            .map((e) =>
                Question.fromJson(e.data() as Map<String, dynamic>, e.id))
            .toList();
        filteredQuestions = _questions;
        notifyListeners();
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      username = prefs.getString('username') ?? '';
      name = prefs.getString('name') ?? '';
      isLogged = CacheHelper.getBoolean(key: 'IsLoggedIn');
      isLoading = false;
    } catch (error) {
      print(error);
      isLoading = false;
      if (!await InternetConnectionChecker().hasConnection) {
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'لا يوجد اتصال بالانترنت',
          btnOkOnPress: () {
            Navigator.pop(navigationKey.currentContext!);
          },
        ).show();
      }
    }
  }

  void filterQuestions() {
    filteredQuestions = _questions
        .where(
          (element) => HelperFunctions.matchesSearch(
            searchController.text.toLowerCase().split(" "),
            element.title,
          ),
        )
        .toList();
    notifyListeners();
  }

  clearSearch() {
    searchController.clear();
    filteredQuestions = _questions;
  }

  Future<void> addQuestion(Question question) async {
    try {
      await FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .add(question.toJson());
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'تم',
        desc: 'تم اضافة السؤال بنجاح',
        btnOkOnPress: () {
          pop();
        },
      ).show();
    } catch (error) {
      print(error);
      if (!await InternetConnectionChecker().hasConnection) {
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'لا يوجد اتصال بالانترنت',
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  Future<void> deleteQuestion(String id) async {
    try {
      pop();
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'تنبيه',
        desc: 'هل انت متأكد من حذف هذا السؤال؟',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await FirebaseFirestore.instance
              .collection('Q&A')
              .doc('questions')
              .collection('questions')
              .doc(id)
              .delete();
          AwesomeDialog(
            context: navigationKey.currentContext!,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            title: 'تم',
            desc: 'تم حذف السؤال بنجاح',
            btnOkOnPress: () {
              // pop();
            },
          ).show();
        },
      ).show();
      // await FirebaseFirestore.instance
      //     .collection('Q&A')
      //     .doc('questions')
      //     .collection('questions')
      //     .doc(id)
      //     .delete();
    } catch (error) {
      print(error);
      if (!await InternetConnectionChecker().hasConnection) {
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'لا يوجد اتصال بالانترنت',
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  // Future<void> updateQuestion(Question question) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('Q&A')
  //         .doc('questions')
  //         .collection('questions')
  //         .doc(question.id)
  //         .update(question.toJson());
  //   } catch (error) {
  //     print(error);
  //           if (!await InternetConnectionChecker().hasConnection) {
  //       AwesomeDialog(
  //         context: navigationKey.currentContext!,
  //         dialogType: DialogType.error,
  //         animType: AnimType.bottomSlide,
  //         title: 'خطأ',
  //         desc: 'لا يوجد اتصال بالانترنت',
  //         btnOkOnPress: () {},
  //       ).show();
  //     }
  //   }
  // }

  Future<void> addAnswer(Question question, String answer) async {
    try {
      showLoaderDialog(navigationKey.currentContext!);
      await FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .doc(question.id)
          .update({
        'answers': FieldValue.arrayUnion([
          Answers(
                  answer: answer,
                  date: Timestamp.now(),
                  name: name,
                  username: username)
              .toJson()
        ]),
        'answersCount': FieldValue.increment(1)
      });
      _questions[_questions.indexOf(question)].answerCount++;
      _questions[_questions.indexOf(question)].answers.add(Answers(
          answer: answer,
          date: Timestamp.now(),
          name: name,
          username: username));
      filteredQuestions = _questions;
      pop();

      notifyListeners();
    } catch (error) {
      pop();

      print(error);
      if (!await InternetConnectionChecker().hasConnection) {
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'لا يوجد اتصال بالانترنت',
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  Future<void> deleteAnswer(Question question, Answers answer) async {
    try {
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'تنبيه',
        desc: 'هل انت متأكد من حذف هذه الإجابة ؟',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await FirebaseFirestore.instance
              .collection('Q&A')
              .doc('questions')
              .collection('questions')
              .doc(question.id)
              .update({
            'answers': FieldValue.arrayRemove([answer.toJson()]),
            'answersCount': FieldValue.increment(-1)
          });
          _questions[_questions.indexOf(question)].answerCount--;
          _questions[_questions.indexOf(question)].answers.remove(answer);
          filteredQuestions = _questions;
        },
      ).show();

      notifyListeners();
    } catch (error) {
      print(error);
      if (!await InternetConnectionChecker().hasConnection) {
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'لا يوجد اتصال بالانترنت',
          btnOkOnPress: () {},
        ).show();
      }
    }
  }
}
