import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/rating/domain/repo/rating_repo.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/rating_model.dart';

class RatingRepoImpl extends RatingRepo {
  @override
  Future<Either<String, String>> rateProduct({
    required String storeId,
    required String productId,
    required double rating,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      var data = await FirebaseFirestore.instance
          .collection('stores')
          .doc(storeId)
          .get();
      StoreModel store = StoreModel.fromMap(data.data()!);
      List<ProductModel> list = store.products ?? [];
      ProductModel model =
          list.firstWhere((element) => element.id == productId);
      List<Rating> ratingList = model.rating;
      Rating rate = Rating(userid: uid, rating: rating);
      ratingList.add(rate);

      ProductModel newModel = ProductModel(
        contact: model.contact,
        ownerUid: model.ownerUid,
        title: model.title,
        description: model.description,
        id: model.id,
        type: model.type,
        image: model.image,
        price: model.price,
        oldPrice: model.oldPrice,
        available: model.available,
        bestSeller: model.bestSeller,
        rating: ratingList,
      );
      list.remove(model);
      list.add(newModel);

      StoreModel sModel = StoreModel(
        image: store.image,
        name: store.name,
        storeOwnerUid: store.storeOwnerUid,
        contact: store.contact,
        isBanned: store.isBanned,
        products: list,
        profits: store.profits,
      );

      await FirebaseFirestore.instance.collection('stores').doc(storeId).update(
            sModel.toMap(),
          );
      return right('');
    } catch (e) {
      return left(e.toString());
    }
  }
}
