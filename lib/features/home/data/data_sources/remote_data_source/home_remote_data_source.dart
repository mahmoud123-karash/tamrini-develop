import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';

import '../../../../../core/cache/shared_preference.dart';

abstract class HomeRemoteDataSource {
  Future<List<StoreModel>> getStores();
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  });
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<List<StoreModel>> getStores() async {
    List<StoreModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('stores')
        .where('isBanned', isEqualTo: false)
        .get();
    for (var element in result.docs) {
      StoreModel model = StoreModel.fromMap(element.data());
      list.add(model);
    }
    return list;
  }

  @override
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  }) async {
    try {
      String message = await handleLocationPermission();
      double lat = CacheHelper.getData(key: 'lat') ?? 0;
      if (message != '' && lat == 0) {
        return left(message);
      } else {
        List<GymModel> list = [];
        var result = await FirebaseFirestore.instance
            .collection('gyms')
            .doc('data')
            .collection('data')
            .get();
        for (var element in result.docs) {
          GeoPoint endLocation = element.data()['location'];
          double distance = await getDistance(
            endLatitude: endLocation.latitude,
            endLongitude: endLocation.longitude,
            update: update,
          );
          GymModel model =
              GymModel.fromJson(element.data(), element.id, distance);
          if (!model.isBanned) {
            list.add(model);
          }
        }
        list.sort((a, b) => a.distance.compareTo(b.distance));
        return right(list);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
