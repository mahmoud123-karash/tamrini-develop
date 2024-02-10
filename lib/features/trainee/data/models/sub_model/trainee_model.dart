import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import '../../../../food/data/models/supplement_model/supplement_data.dart';
import 'course_model.dart';
import 'follow_up_model.dart';
import 'food_model.dart';

class TraineeModel {
  final String uid;
  final Timestamp dateOfSubscription;
  final List<SupplementData> supplements;
  final List<FoodModel> food;
  final List<FollowUpModel> followUpList;
  final List<CourseModel> courses;
  UserModel? user;

  TraineeModel({
    required this.uid,
    required this.dateOfSubscription,
    required this.supplements,
    required this.food,
    required this.followUpList,
    required this.courses,
    this.user,
  });
  factory TraineeModel.fromJson(Map<String, dynamic> json, user) {
    List<SupplementData> supplementsList =
        (json['supplements'] as List<dynamic>)
            .map((data) => SupplementData.fromJson(data))
            .toList();
    List<FoodModel> foodList = (json['food'] as List<dynamic>)
        .map((data) => FoodModel.fromJson(data))
        .toList();
    List<FollowUpModel> followUpList = (json['followUpList'] as List<dynamic>)
        .map((data) => FollowUpModel.fromJson(data))
        .toList();
    List<CourseModel> coursesList = (json['courses'] as List<dynamic>)
        .map((data) => CourseModel.fromJson(data))
        .toList();

    return TraineeModel(
      user: user,
      uid: json['uid'],
      dateOfSubscription: json['dateOfSubscription'],
      supplements: supplementsList,
      food: foodList,
      followUpList: followUpList,
      courses: coursesList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> supplementsJson =
        supplements.map((data) => data.toJson()).toList();
    List<Map<String, dynamic>> foodJson =
        food.map((data) => data.toJson()).toList();
    List<Map<String, dynamic>> followUpListJson =
        followUpList.map((data) => data.toJson()).toList();
    List<Map<String, dynamic>> coursesJson =
        courses.map((data) => data.toJson()).toList();

    return {
      'uid': uid,
      'dateOfSubscription': dateOfSubscription,
      'supplements': supplementsJson,
      'food': foodJson,
      'followUpList': followUpListJson,
      'courses': coursesJson,
    };
  }
}
