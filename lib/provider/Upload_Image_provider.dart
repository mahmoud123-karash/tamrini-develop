import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

List<File> photo = [];

List allPhotos = [];

class UploadProvider with ChangeNotifier {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickMultiImage(imageQuality: 50);

    photo = pickedFile.map((e) => File(e.path)).toList();
    allPhotos += photo;
    photo.clear();
    print(allPhotos);
    print(allPhotos[0].runtimeType.toString());
    notifyListeners();
  }

  Future videoFromGallery() async {
    XFile xFile;
    final pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );

    print(pickedFile?.path);
    if (pickedFile != null) {
      allPhotos.add(pickedFile);
    } else {
      print('No file selected.');
    }
    notifyListeners();
  }

  Future oneImgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
          imageQuality: 50, source: ImageSource.gallery);

      if (pickedFile != null) {
        allPhotos.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    } on Exception catch (e) {
      print(e);
      // TODO
    }
    notifyListeners();
  }

  Future imgFromCamera() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    if (pickedFile != null) {
      photo.add(File(pickedFile.path));
      allPhotos += photo;
      photo.clear();
    } else {
      print('No image selected.');
    }
    print(allPhotos);
    print(allPhotos[0].runtimeType.toString());

    notifyListeners();
  }

  removeImage(int index) {
    allPhotos.removeAt(index);
    notifyListeners();
  }

  Future<List<String>> uploadFiles() async {
    List<String> downloadUrls = [];

    if (allPhotos.isEmpty) {
      return downloadUrls;
    }

    for (var i in allPhotos) {
      try {
        if (i.runtimeType.toString() == "_File") {
          var file = i;
          var fileName = removeSpecialAndArabicChars(basename(file.path));
          var destination =
              'images/${DateTime.now().millisecondsSinceEpoch.toString()}$fileName';
          var snapshot = await storage.ref().child(destination).putFile(file);
          // store the image path in firebase

          print("bucket: ${snapshot.ref.bucket}");
          print("fullPath: ${snapshot.ref.fullPath}");
          print("parent Name: ${snapshot.ref.parent!.name}");
          print("name: ${snapshot.ref.name}");
          print("hashcode: ${snapshot.ref.hashCode}");
          downloadUrls
              .add("gs://" + snapshot.ref.bucket + '/' + snapshot.ref.fullPath);
          // allPhotos.remove(photo[i]); //remove uploaded image from list
        } else if (i.runtimeType.toString() == "XFile") {
          File file = File(i.path);
          var fileName = removeSpecialAndArabicChars(basename(i.path));

          var destination =
              'videos/${DateTime.now().millisecondsSinceEpoch.toString()}$fileName';

          var snapshot = await storage.ref().child(destination).putFile(file);
          downloadUrls.add(await snapshot.ref.getDownloadURL());
        } else {
          print("preExist Image : $i");
          downloadUrls.add(i);
        }
      } on Exception catch (e) {
        print("image uploade error : $e");
        Fluttertoast.showToast(msg: e.toString());

        // TODO
      }
    }

    photo = [];
    notifyListeners();
    return downloadUrls;
  }

  String removeSpecialAndArabicChars(String str) {
    final regex =
        RegExp(r'[^\w\s./]|(?<=\.)|(?<=/)|(?=\.)|(?=/)|[\u0600-\u06FF]');
    return str.replaceAll(regex, '').removeAllWhitespace;
  }

  // compare two lists new and old and delete the old images that not exist in new list from firebase storage
  Future deleteOldImages(
      {required List<String> newImages,
      required List<String> oldImages}) async {
    List<String> deletedImages = [];
    for (var i in oldImages) {
      if (!newImages.contains(i)) {
        deletedImages.add(i);
      }
    }
    for (var i in deletedImages) {
      try {
        if (i.contains('gs://tamrini-app')) {
          await storage.ref(i.split('tamrini-app.appspot.com/')[1]).delete();
        } else {
          await storage.refFromURL(i).delete();
        }
      } on Exception catch (e) {
        print("image delete error : $e");
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  Future deleteAllAssets(List<String> assets) async {
    for (var i in assets) {
      try {
        if (i.contains('gs://tamrini-app')) {
          await storage.ref(i.split('tamrini-app.appspot.com/')[1]).delete();
        } else {
          await storage.refFromURL(i).delete();
        }
      } on Exception catch (e) {
        print("image delete error : $e");
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  Future<File?> getImgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
          imageQuality: 50, source: ImageSource.gallery);

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        print('No image selected.');
        return null;
      }
    } on Exception catch (e) {
      print(e);
      print('Error get image from Gallery.');
      return null;
    }
  }

  Future<File?> getImgFromCamera() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> downloadUrls = [];

    if (images.isEmpty) {
      return downloadUrls;
    }

    for (var i in images) {
      try {
        if (i.runtimeType.toString() == "_File") {
          var file = i;
          var fileName = removeSpecialAndArabicChars(basename(file.path));
          var destination =
              'images/${DateTime.now().millisecondsSinceEpoch.toString()}$fileName';
          var snapshot = await storage.ref().child(destination).putFile(file);
          // store the image path in firebase

          print("bucket: ${snapshot.ref.bucket}");
          print("fullPath: ${snapshot.ref.fullPath}");
          print("parent Name: ${snapshot.ref.parent!.name}");
          print("name: ${snapshot.ref.name}");
          print("hashcode: ${snapshot.ref.hashCode}");
          downloadUrls
              .add("gs://" + snapshot.ref.bucket + '/' + snapshot.ref.fullPath);
          // allPhotos.remove(photo[i]); //remove uploaded image from list
        } else {
          print("preExist Image : $i");
          downloadUrls.add(i.path);
        }
      } on Exception catch (e) {
        print("image uploade error : $e");
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    notifyListeners();
    return downloadUrls;
  }
}
