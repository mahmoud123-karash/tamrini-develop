import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';

class ArticleModel {
  late Timestamp? date;
  late List<String>? image;
  late String? writerUid;
  late String? body;
  late String? title;
  late String? id;
  late bool? isPending;
  late bool? isRefused;
  UserModel? user;

  ArticleModel({
    required this.date,
    required this.image,
    required this.writerUid,
    required this.body,
    required this.id,
    required this.title,
    required this.isPending,
    required this.isRefused,
    this.user,
  });

  factory ArticleModel.fromJson(
    Map<String, dynamic> data,
    String id,
    UserModel user,
  ) {
    return ArticleModel(
      date: data['date'],
      id: id,
      image: data['image'].cast<String>(),
      writerUid: data['writerUid'] ?? adminUid,
      isPending: data['isPending'] ?? false,
      isRefused: data['isRefused'] ?? false,
      body: data['body'],
      title: data['title'],
      user: user,
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "image": image,
        "writerUid": writerUid,
        "isPending": isPending,
        "body": body,
        "title": title,
        "isRefused": isRefused,
      };
}
