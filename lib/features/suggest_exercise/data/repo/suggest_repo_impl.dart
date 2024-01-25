import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/suggest_exercise/data/data_sources/remote_data_source/suggest_remote_data_source.dart';
import 'package:tamrini/features/suggest_exercise/data/models/suggest_model/suggest_model.dart';
import 'package:tamrini/features/suggest_exercise/domain/repo/suggest_repo.dart';
import 'package:uuid/uuid.dart';

class SuggestRepoIpml extends SuggestRepo {
  final SuggestRemoteDataSource suggestRemoteDataSource;

  SuggestRepoIpml(this.suggestRemoteDataSource);
  @override
  Future<Either<String, List<SuggestModel>>> getSuggestedExercises() async {
    try {
      List<SuggestModel> list = await suggestRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> suggestExercise({
    required String title,
    required String url,
    required String imagePath,
  }) async {
    try {
      var uuid = const Uuid().v4();
      late String image;
      if (imagePath != '') {
        List files = [];
        files.add(File(imagePath));
        List<String> images = await uploadFiles(files: files);
        image = images.first;
      } else {
        image = '';
      }
      SuggestModel model =
          SuggestModel(id: uuid, title: title, url: url, image: image);
      await FirebaseFirestore.instance
          .collection('suggested_exercises')
          .doc(uuid)
          .set(
            model.toJson(),
          );
      return right('');
    } catch (e) {
      return left(e.toString());
    }
  }
}
