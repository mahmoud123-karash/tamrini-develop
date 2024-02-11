import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/rating_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

abstract class TrainerRemoteDataSource {
  Future<List<TrainerModel>> get();
}

class TrainerRemoteDataSourceImpl extends TrainerRemoteDataSource {
  @override
  Future<List<TrainerModel>> get() async {
    List<TrainerModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('trainers')
        .doc('data')
        .collection('data')
        .get();

    for (var element in result.docs) {
      double rating = await getRating(uid: element.id);
      UserModel? user = await getUser(element);
      if (user != null) {
        TrainerModel model =
            TrainerModel.fromJson(element.data(), rating, user);
        list.add(model);
      }
    }
    list.sort(
      (a, b) => b.traineesCount.compareTo(a.traineesCount),
    );
    return list;
  }

  Future<double> getRating({required String uid}) async {
    List<Rating> rating = [];
    var result = await FirebaseFirestore.instance
        .collection('rating')
        .doc('data')
        .collection('trainers')
        .doc(uid)
        .collection('rates')
        .get();

    for (var element in result.docs) {
      Rating model = Rating.fromJson(element.data());
      rating.add(model);
    }
    return calculateAverageRating(rating);
  }

  Future<UserModel?> getUser(
    QueryDocumentSnapshot<Map<String, dynamic>> element,
  ) async {
    String askerUid = element.data()['uid'] ?? '';
    if (askerUid != '') {
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(askerUid)
          .get();
      if (result.data() == null) {
        return null;
      } else {
        GeoPoint defultLocation = const GeoPoint(33.312805, 44.361488);
        GeoPoint location = result.data()!['location'] ?? defultLocation;
        String address = await getAddress(location: location);
        UserModel user = UserModel.fromMap(result.data()!, result.id, address);
        return user;
      }
    } else {
      return null;
    }
  }
}
