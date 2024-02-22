import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/services.dart';
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
      String askerUid = element.data()['askerUid'] ?? '';
      UserModel? user = askerUid == '' ? null : await getUser(askerUid);
      if (user != null) {
        QuestionModel model =
            QuestionModel.fromJson(element.data(), element.id, user);
        if (model.askerUid != '') {
          list.add(model);
        }
      }
    }
    return list;
  }
}
