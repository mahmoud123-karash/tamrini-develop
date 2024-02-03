import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';

abstract class QuestionRemoteDataSource {
  Future<List<QuestionModel>> get();
}

class QuestionRemoteDataSourceImpl extends QuestionRemoteDataSource {
  @override
  Future<List<QuestionModel>> get() async {
    List<QuestionModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('Q&A')
        .doc('questions')
        .collection('questions')
        .orderBy('date', descending: true)
        .get();

    for (var element in result.docs) {
      UserModel user = await getAsker(element);
      QuestionModel model =
          QuestionModel.fromJson(element.data(), element.id, user);
      list.add(model);
    }
    return list;
  }

  Future<UserModel> getAsker(
    QueryDocumentSnapshot<Map<String, dynamic>> element,
  ) async {
    String askerUid = element.data()['askerUid'] ?? adminUid;
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(askerUid)
        .get();
    GeoPoint defultLocation = const GeoPoint(33.312805, 44.361488);
    GeoPoint location = result.data() == null
        ? defultLocation
        : result.data()!['location'] ?? defultLocation;
    String address = await getAddress(location: location);
    UserModel user = UserModel.fromMap(result.data()!, result.id, address);
    return user;
  }
}
