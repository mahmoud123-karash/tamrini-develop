import 'trainer_gallery_item.dart';

class Trainer {
  String? name;
  String? image;
  String? description;
  String? gender;
  int? price;
  List<String>? contacts;
  int? traineesCount;
  String? uid;
  List<String>? questions;
  List<dynamic>? gallery;

  Trainer({
    this.name,
    this.image =
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
    this.description,
    this.contacts,
    this.uid,
    this.price,
    this.traineesCount,
    this.gender,
    this.questions,
    this.gallery,
  });

  Trainer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['image'] == null || json['image'] == "") {
      image =
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    } else {
      image = json['image'];
    }
    description = json['achievements'];
    contacts = json['contacts'].cast<String>();

    price = json['price'];
    gender = json['gender'];
    traineesCount = json['traineesCount'];
    uid = json['uid'];
    questions = json['questions'].cast<String>();

    print('gallery: ${json['gallery']}');

    // if (json['gallery'] != null && json['gallery']?.isNotEmpty) {
    //   gallery = json['gallery']?.map((galleryItem) => TrainerGalleryItem.fromJson(galleryItem)).toList();
    // }
    gallery = json['gallery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['achievements'] = this.description;
    data['contacts'] = this.contacts;

    data['uid'] = this.uid;
    data['price'] = this.price;
    data['gender'] = this.gender;
    data['traineesCount'] = this.traineesCount;
    data['questions'] = this.questions;
    data['gallery'] = gallery;
    return data;
  }
}
