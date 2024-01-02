import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/firebase_stuff/firestore.dart';
import 'package:tamrini/model/trainer_gallery_item.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../model/trainee.dart';
import '../model/trainer.dart';
import '../utils/helper_functions.dart';
import 'Upload_Image_provider.dart';

class TrainerProvider extends ChangeNotifier {
  List<Trainer> trainers = [], _originalTrainers = [], pendingTrainers = [];
  Trainee? selectedTrainee;

  UserProvider? user;
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  initiate(UserProvider user) {
    this.user = user;
    print('initiate trainer provider');
    print(user.user.role);

    notifyListeners();
  }

  Future<void> fetchAndSetTrainers() async {
    try {
      isLoading = true;
      FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .getSavy()
          .then((event) {
        print('--- inside fetch trainer ---');
        trainers = event.docs
            .map((e) => Trainer.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        _originalTrainers = trainers;

        isLoading = false;
        notifyListeners();
      });
    } catch (error) {
      isLoading = false;
      print(error);
    }
  }

  Future<void> subscribeAsTrainer(Trainer trainer) async {
    if (user!.isCaptain || user!.isAdmin) return;
    try {
      trainer.uid = user!.user.uid;
      // trainer.uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('pending')
          .collection('data')
          .add(trainer.toJson());
      pop();

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'تم الاشتراك بنجاح',
        desc: 'سيتم التواصل معك قريبا',
        btnOkOnPress: () {
          pop();
        },
      ).show();
    } catch (error) {
      print(error);

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'حدث خطأ',
        desc: 'حاول مرة اخرى',
        btnOkOnPress: () {},
      ).show();
    }
  }

  searchTrainer() {
    if (searchController.text.isEmpty ||
        searchController.text == '' ||
        searchController.text == ' ') {
      trainers = _originalTrainers;
      notifyListeners();
      return;
    }
    trainers = _originalTrainers
        .where(
          (element) => HelperFunctions.matchesSearch(
            searchController.text.toLowerCase().split(" "),
            element.name!,
          ),
        )
        .toList();
    notifyListeners();
  }

  clearSearch() {
    trainers = _originalTrainers;
    searchController.clear();
  }

  Future<void> deleteTrainer(Trainer trainer) async {
    if (!user!.isAdmin) return;
    try {
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'هل انت متأكد؟',
        desc: 'سيتم حذف المدرب نهائيا',
        btnCancelOnPress: () {
          return;
        },
        btnOkOnPress: () async {
          var data = trainer.image;
          FirebaseFirestore.instance
              .collection('trainers')
              .doc('data')
              .collection('data')
              .where('uid', isEqualTo: trainer.uid)
              .getSavy()
              .then((value) async {
            await UploadProvider().deleteAllAssets([data!]);

            value.docs.first.reference.delete();
          });

          await FirebaseFirestore.instance
              .collection('users')
              .doc(trainer.uid)
              .update({'role': 'user'});

          trainers.remove(trainer);
          _originalTrainers.remove(trainer);
          notifyListeners();

          AwesomeDialog(
            context: navigationKey.currentContext!,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'تم الحذف بنجاح',
            desc: 'تم حذف المدرب بنجاح',
            btnOkOnPress: () {},
          ).show();
        },
      ).show();
    } catch (error) {
      print(error);

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'حدث خطأ',
        desc: 'حاول مرة اخرى',
        btnOkOnPress: () {},
      ).show();
    }
  }

  /// Use this method to get pending trainers for Admin only
  Future<void> fetchAndSetPendingTrainers() async {
    if (!user!.isAdmin) return;
    try {
      isLoading = true;
      FirebaseFirestore.instance
          .collection('trainers')
          .doc('pending')
          .collection('data')
          .getSavy()
          .then((event) {
        pendingTrainers = event.docs.map((e) {
          print(e.data().toString());
          return Trainer.fromJson(e.data() as Map<String, dynamic>);
        }).toList();
        isLoading = false;
        notifyListeners();
      });
    } catch (error) {
      isLoading = false;
      print(error);
    }
  }

  Future<void> acceptTrainer(Trainer trainer) async {
    if (!user!.isAdmin) return;
    try {
      trainer.traineesCount = 0;

      print(trainer.toJson().toString());
      showLoaderDialog(navigationKey.currentContext!);
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .add(trainer.toJson());

      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('pending')
          .collection('data')
          .where('uid', isEqualTo: trainer.uid)
          .getSavy()
          .then((value) {
        for (var doc in value.docs) {
          doc.reference.delete();
        }
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(trainer.uid)
          .update({'role': 'captain'});

      pop();

      pendingTrainers.remove(trainer);
      trainers.add(trainer);
      _originalTrainers.add(trainer);
      notifyListeners();

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'تم القبول بنجاح',
        desc: 'تم قبول المدرب بنجاح',
        btnOkOnPress: () {},
      ).show();
    } catch (error) {
      print(error);

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'حدث خطأ',
        desc: 'حاول مرة اخرى',
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future<void> rejectTrainer(Trainer trainer) async {
    try {
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'هل انت متأكد؟',
        desc: 'سيتم رفض المدرب نهائيا',
        btnCancelOnPress: () {
          return;
        },
        btnOkOnPress: () async {
          await FirebaseFirestore.instance
              .collection('trainers')
              .doc('pending')
              .collection('data')
              .where('uid', isEqualTo: trainer.uid)
              .getSavy()
              .then((value) async {
            for (var doc in value.docs) {
              doc.reference.delete();
            }
            await UploadProvider().deleteAllAssets([trainer.image!]);
          });

          pendingTrainers.remove(trainer);
          notifyListeners();
          AwesomeDialog(
            context: navigationKey.currentContext!,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'تم الرفض بنجاح',
            desc: 'تم رفض المدرب بنجاح',
            btnOkOnPress: () {},
          ).show();
        },
      ).show();
    } catch (error) {
      print(error);

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'حدث خطأ',
        desc: 'حاول مرة اخرى',
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future<void> editTrainerData(Trainer trainer) async {
    if (!user!.isCaptain) return;
    try {
      var oldImage =
          trainers.firstWhere((element) => element.uid == trainer.uid).image;
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'هل انت متأكد؟',
        desc: 'سيتم تعديل بيانات المدرب',
        btnCancelOnPress: () {
          return;
        },
        btnOkOnPress: () {
          FirebaseFirestore.instance
              .collection('trainers')
              .doc('data')
              .collection('data')
              .where('uid', isEqualTo: trainer.uid)
              .getSavy()
              .then((value) async {
            if (oldImage != trainer.image) {
              await UploadProvider().deleteAllAssets([oldImage!]);
            }
            value.docs.first.reference.update(trainer.toJson());

            trainers.removeWhere((element) => element.uid == trainer.uid);
            trainers.add(trainer);
            _originalTrainers = trainers;
            notifyListeners();
          });
          AwesomeDialog(
            context: navigationKey.currentContext!,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'تم التعديل بنجاح',
            desc: 'تم تعديل بيانات المدرب بنجاح',
            btnOkOnPress: () {},
          ).show();
        },
      ).show();
    } catch (error) {
      print(error);

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'حدث خطأ',
        desc: 'حاول مرة اخرى',
        btnOkOnPress: () {},
      ).show();
    }
  }

  /// ------------------------  trainee Part  ------------------------ ///
  ///
  ///
  FollowUpData addFollowUpToTrainee(List questions, List answers, List images) {
    if (answers.length != questions.length) {
      throw Exception("answers.length != questions.length");
    }
    var followUpData = [];
    for (int i = 0; i < questions.length; i++) {
      followUpData.add({
        "question": questions[i],
        "answer": answers[i],
      });
    }
    var data = FollowUpData(
      createdAt: Timestamp.now(),
      followUpData: followUpData.cast(),
      images: images.cast<String>(),
    );
    log(data.toJson().toString());
    return data;
  }

  Future<void> subscribeToTrainer(
      {required Trainer trainer,
      required List answers,
      required List images}) async {
    try {
      showLoaderDialog(navigationKey.currentContext!);

      var traineeData = Trainee(
        name: user!.user.name,
        number: user!.user.phone,
        username: user!.user.username,
        uid: user!.user.uid,
        age: user!.user.age,
        gender: user!.user.gender,
        followUpList: [
          addFollowUpToTrainee(trainer.questions!, answers, images)
        ],
      ).toJson();

      traineeData['trainerID'] = trainer.uid;
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc('pending')
          .collection('data')
          .add(traineeData);

      pop();

      notifyListeners();

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'تم ارسال الطلب بنجاح',
        desc:
            'برجاء التواصل مع المدرب على وسائل التواصل الاجتماعي حتى يتم قبول طلبك',
        btnOkOnPress: () {
          pop();
          pop();
        },
      ).show();
    } catch (error) {
      print(error);

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'حدث خطأ',
        desc: 'حاول مرة اخرى',
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future<void> addToGallery(Trainer trainer, List<String> images) async {
    if (!user!.isCaptain) return;
    try {
      var data = TrainerGalleryItem(
        createdAt: Timestamp.now(),
        before: images[0],
        after: images[1],
      );

      FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .where('uid', isEqualTo: trainer.uid)
          .getSavy()
          .then((value) async {
        value.docs.first.reference.update({
          'gallery': FieldValue.arrayUnion([data.toJson()])
        });
        //
        // trainers.removeWhere((element) => element.uid == trainer.uid);
        // trainers.add(trainer);
        // _originalTrainers = trainers;

        notifyListeners();
        fetchAndSetTrainers();
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'تمت العملية بنجاح',
          desc: 'تم اضافه العمل الي المعرض',
          btnOkOnPress: () {
            pop();
          },
        ).show();
      });
    } catch (error) {
      print(error);
      pop();
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'حدث خطأ',
        desc: 'حاول مرة اخرى',
        btnOkOnPress: () {},
      ).show();
    }
  }
}
