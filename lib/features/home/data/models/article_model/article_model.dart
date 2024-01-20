import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';

class ArticleModel {
  late Timestamp? date;
  late List<String>? image;
  late String? writer;
  late String? writerUid;
  late String? body;
  late String? title;
  late String? id;
  late bool? isBanned;

  ArticleModel(
      {required this.date,
      required this.image,
      required this.writer,
      required this.writerUid,
      required this.body,
      required this.id,
      required this.title,
      required this.isBanned});

  factory ArticleModel.fromJson(Map<String, dynamic> data, String id) {
    return ArticleModel(
      date: data['date'],
      id: id,
      image: data['image'].cast<String>(),
      writer: data['writer'],
      writerUid: data['writerUid'] ?? adminUid,
      isBanned: data['isBanned'] ?? false,
      body: data['body'],
      title: data['title'],
    );
  }
}
