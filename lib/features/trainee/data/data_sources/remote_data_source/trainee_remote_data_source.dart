import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';

abstract class TraineeRemoteDataSource {
  Future<List<TraineeModel>> get({required String trainerId});
  Future<TraineeModel> getUserCourse();
}

class TraineeRemoteDataSourceImpl extends TraineeRemoteDataSource {
  @override
  Future<List<TraineeModel>> get({required String trainerId}) async {
    List<TraineeModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('trainees')
        .doc(trainerId)
        .collection('data')
        .get();

    for (var element in result.docs) {
      UserModel user = await getAsker(element);
      list.add(TraineeModel.fromJson(element.data(), user));
    }
    return list;
  }

  Future<UserModel> getAsker(
    QueryDocumentSnapshot<Map<String, dynamic>> element,
  ) async {
    String askerUid = element.data()['uid'] ?? '';
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(askerUid)
        .get();
    UserModel user = UserModel.fromMap(result.data()!, result.id);
    return user;
  }

  @override
  Future<TraineeModel> getUserCourse() async {
    String uid = CacheHelper.getData(key: 'uid');
    String trainerId = CacheHelper.getData(key: 'trainerId');
    var result = await FirebaseFirestore.instance
        .collection('trainees')
        .doc(trainerId)
        .collection('data')
        .doc(uid)
        .get();

    TraineeModel model = TraineeModel.fromJson(result.data()!, null);
    return model;
  }
}
