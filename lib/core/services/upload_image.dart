import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:path/path.dart';

Future<List<String>> uploadFiles({
  required List files,
}) async {
  var storage = firebase_storage.FirebaseStorage.instance;
  List<String> downloadUrls = [];

  if (files.isEmpty) {
    return downloadUrls;
  }

  for (var i in files) {
    if (i.runtimeType.toString() == "_File") {
      var file = i;
      var fileName = removeSpecialAndArabicChars(basename(file.path));
      var destination =
          'images/${DateTime.now().millisecondsSinceEpoch.toString()}$fileName';
      var snapshot = await storage.ref().child(destination).putFile(file);
      downloadUrls
          .add('${"gs://${snapshot.ref.bucket}"}/${snapshot.ref.fullPath}');
    } else if (i.runtimeType.toString() == "XFile") {
      File file = File(i.path);
      var fileName = removeSpecialAndArabicChars(basename(i.path));
      var destination =
          'videos/${DateTime.now().millisecondsSinceEpoch.toString()}$fileName';
      var snapshot = await storage.ref().child(destination).putFile(file);
      downloadUrls.add(await snapshot.ref.getDownloadURL());
    }
  }
  return downloadUrls;
}

String removeSpecialAndArabicChars(String str) {
  final regex =
      RegExp(r'[^\w\s./]|(?<=\.)|(?<=/)|(?=\.)|(?=/)|[\u0600-\u06FF]');
  return str.replaceAll(regex, '').removeAllWhitespace;
}

Future deleteOldImages({
  required List<String> newImages,
  required List<String> oldImages,
}) async {
  var storage = firebase_storage.FirebaseStorage.instance;
  List<String> deletedImages = [];
  for (var i in oldImages) {
    if (!newImages.contains(i)) {
      deletedImages.add(i);
    }
  }
  for (var i in deletedImages) {
    if (i.contains('gs://tamrini-app')) {
      await storage.ref(i.split('tamrini-app.appspot.com/')[1]).delete();
    } else {
      await storage.refFromURL(i).delete();
    }
  }
}
