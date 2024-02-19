import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/gallery_model.dart';

class TrainerModel {
  final bool isBanned;
  final bool isRequestProfits;
  final String description;
  final int price;
  final int traineesCount;
  final String uid;
  final String fromH;
  final String toH;
  final num profits;
  final List<GalleryModel> gallery;
  double? rating;
  UserModel? user;
  final List<String> questionsTrainees;

  TrainerModel({
    this.rating,
    required this.isBanned,
    required this.isRequestProfits,
    required this.description,
    required this.uid,
    required this.price,
    required this.traineesCount,
    required this.profits,
    required this.questionsTrainees,
    this.user,
    required this.gallery,
    required this.fromH,
    required this.toH,
  });

  factory TrainerModel.fromJson(
      Map<String, dynamic> json, double rating, user) {
    List<GalleryModel> list = [];
    if (json['gallery'] != null) {
      json['gallery'].forEach(
        (element) {
          GalleryModel model = GalleryModel.formJson(element);
          list.add(model);
        },
      );
    }
    return TrainerModel(
      isBanned: json['isBanned'] ?? false,
      isRequestProfits: json['isRequestProfits'] ?? false,
      rating: rating,
      description: json['achievements'] ?? "",
      questionsTrainees: List<String>.from(json['questionsTrainees'] ?? []),
      price: json['price'] ?? 0,
      user: user,
      traineesCount: json['traineesCount'] ?? 0,
      uid: json['uid'] ?? '',
      fromH: json['fromH'] ?? '',
      profits: json['profits'] ?? 0,
      toH: json['toH'] ?? '',
      gallery: list,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isBanned'] = isBanned;
    data['isRequestProfits'] = isRequestProfits;
    data['achievements'] = description;
    data['uid'] = uid;
    data['price'] = price;
    data['fromH'] = fromH;
    data['toH'] = toH;
    data['questionsTrainees'] = questionsTrainees;
    data['profits'] = profits;
    data['traineesCount'] = traineesCount;
    data['gallery'] = gallery.map((e) => e.toJson());
    return data;
  }
}
