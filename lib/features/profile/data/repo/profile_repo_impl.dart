import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/profile/data/data_sources/local_data_source/profile_local_data_source.dart';
import 'package:tamrini/features/profile/data/data_sources/remote_data_source/profile_remote_data_source.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/domain/repo/profile_repo.dart';
import 'package:path/path.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemotedataSource profileRemotedataSource;
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileRepoImpl(this.profileRemotedataSource, this.profileLocalDataSource);
  @override
  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      List<ProfileModel> list = profileLocalDataSource.get();
      if (list.isNotEmpty) {
        return right(list.first);
      } else {
        ProfileModel model = await profileRemotedataSource.get();
        return right(model);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  void updateProfile({required ProfileModel model}) {
    String uid = CacheHelper.getData(key: 'uid');
    FirebaseFirestore.instance.collection('users').doc(uid).update(
          model.toMap(),
        );
  }

  @override
  Future<Either<String, XFile>> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return right(image);
    }
    return left('No Image');
  }

  @override
  Future<String> uploadImge({required File imageFile}) async {
    var storage = firebase_storage.FirebaseStorage.instance;

    var fileName = removeSpecialAndArabicChars(basename(imageFile.path));
    var destination =
        'images/${DateTime.now().millisecondsSinceEpoch.toString()}$fileName';
    var snapshot = await storage.ref().child(destination).putFile(imageFile);

    String uri = 'gs://${snapshot.ref.bucket}/${snapshot.ref.fullPath}';

    return uri;
  }

  String removeSpecialAndArabicChars(String str) {
    final regex =
        RegExp(r'[^\w\s./]|(?<=\.)|(?<=/)|(?=\.)|(?=/)|[\u0600-\u06FF]');
    return str.replaceAll(regex, '').removeAllWhitespace;
  }

  @override
  void removeOldProfileImage({required String imagePath}) async {
    var storage = firebase_storage.FirebaseStorage.instance;
    if (imagePath.contains('gs://tamrini-app')) {
      await storage
          .ref(imagePath.split('tamrini-app.appspot.com/')[1])
          .delete();
    } else {
      await storage.refFromURL(imagePath).delete();
    }
  }
}
