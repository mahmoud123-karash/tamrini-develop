import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    log(status.toString());
    Directory directory = Directory("");
    if (Platform.isAndroid) {
      directory = Directory("/storage/emulated/0/Download");
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    String exPath = directory.path;
    //await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<void> writeCounter(List<int> bytes, String name) async {
    final path = await getExternalDocumentPath();
    File file = File('$path/$name');
    await file.writeAsBytes(bytes);
  }
}
