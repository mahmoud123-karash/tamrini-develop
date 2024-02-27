import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    var status1 = await Permission.storage.status;
    var status2 = await Permission.accessMediaLocation.status;
    var status3 = await Permission.manageExternalStorage.status;

    if (!status1.isGranted) {
      await Permission.storage.request();
    }
    if (!status2.isGranted) {
      await Permission.accessMediaLocation.request();
    }
    if (!status3.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    Directory directory = Directory("");
    if (Platform.isAndroid) {
      directory = Directory("/storage/emulated/0/Download");
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    String exPath = directory.path;
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<void> writeCounter(List<int> bytes, String name) async {
    final path = await getExternalDocumentPath();
    File file = File('$path/$name');
    await file.writeAsBytes(bytes);
  }
}
