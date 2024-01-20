import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  late Timestamp date;
  late String name;
  late List<Answers> answers;
  late String askerUsername;
  late String body;
  late String title;
  late String id;
  late int answerCount;

  Question(
      {required this.date,
      required this.name,
      required this.answers,
      required this.askerUsername,
      required this.body,
      required this.title});

  Question.fromJson(Map<String, dynamic> json, String id) {
    date = json['date'];
    name = json['name'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
    askerUsername = json['askerUsername'];
    body = json['body'];
    title = json['title'];
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['name'] = this.name;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    data['askerUsername'] = this.askerUsername;
    data['body'] = this.body;
    data['title'] = this.title;
    return data;
  }
}

class Answers {
  Timestamp? date;
  String? answer;
  String? name;
  String? username;

  Answers({this.date, this.answer, this.name, this.username});

  Answers.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    answer = json['answer'];
    name = json['name'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['answer'] = this.answer;
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}
