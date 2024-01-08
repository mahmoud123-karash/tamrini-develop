import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/rating_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

abstract class TrainerRemoteDataSource {
  Future<List<TrainerModel>> get();
  Future<double> getRating({required String uid});
}

class TrainerRemoteDataSourceImpl extends TrainerRemoteDataSource {
  @override
  Future<List<TrainerModel>> get() async {
    List<TrainerModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('trainers')
        .doc('data')
        .collection('data')
        .where('isBanned', isEqualTo: false)
        .get();

    for (var element in result.docs) {
      GeoPoint location =
          element.data()['location'] ?? const GeoPoint(33.312805, 44.361488);
      String address = await getAddress(location: location);
      double rating = await getRating(uid: element.id);
      TrainerModel model =
          TrainerModel.fromJson(element.data(), address, rating);
      list.add(model);
    }
    list.sort(
      (a, b) => b.traineesCount.compareTo(a.traineesCount),
    );
    return list;
  }

  @override
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
}
