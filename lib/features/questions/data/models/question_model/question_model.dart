import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';

class QuestionModel {
  final Timestamp date;
  final String body;
  final String askerUid;
  String? id;
  final List<AnswerModel> answers;
  final int answersCount;
  final bool isBanned;
  UserModel? user;

  QuestionModel({
    required this.date,
    required this.body,
    required this.askerUid,
    this.id,
    required this.answersCount,
    required this.answers,
    required this.isBanned,
    this.user,
  });

  factory QuestionModel.fromJson(
      Map<String, dynamic> json, String id, UserModel user) {
    final List<dynamic> jsonAnswers = json['answers'] ?? [];
    final List<AnswerModel> answers = jsonAnswers
        .map(
          (jsonAnswer) => AnswerModel.fromJson(jsonAnswer),
        )
        .toList();
    return QuestionModel(
      date: json['date'] ?? Timestamp.now(),
      answers: answers,
      askerUid: json['askerUid'] ?? adminUid,
      body: json['body'] ?? '',
      isBanned: json['isBanned'] ?? false,
      answersCount: json['answersCount'] ?? 0,
      id: id,
      user: user,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['answers'] = answers.map((v) => v.toJson()).toList();
    data['body'] = body;
    data['isBanned'] = isBanned;
    data['askerUid'] = askerUid;
    data['answersCount'] = answersCount;
    return data;
  }
}

Future<UserModel> getAsker(
    QueryDocumentSnapshot<Map<String, dynamic>> element) async {
  String askerUid = element.data()['askerUid'] ?? adminUid;
  var result =
      await FirebaseFirestore.instance.collection('users').doc(askerUid).get();
  UserModel user = UserModel.fromMap(result.data()!, result.id);
  return user;
}
