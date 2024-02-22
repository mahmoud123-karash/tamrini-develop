import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/gym/data/models/subscriber_model/subscriber_model.dart';
import 'package:tamrini/features/subscribtions/data/data_sources/local_data_source/subscribtion_local_data_source.dart';
import 'package:tamrini/features/subscribtions/data/data_sources/remote_data_source/subscribtion_remote_data_source.dart';
import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';
import 'package:tamrini/features/subscribtions/domain/repo/subscription_repo.dart';
import 'package:uuid/uuid.dart';

class SubscriptionRepoImpl extends SubscriptionRepo {
  final SubscriptionRemoteDataSource subscriptionRemoteDataSource;
  final SubscribtionLocalDataSource subscribtionLocalDataSource;

  SubscriptionRepoImpl(
    this.subscriptionRemoteDataSource,
    this.subscribtionLocalDataSource,
  );
  @override
  Future<Either<String, List<SubscriptionModel>>> get() async {
    try {
      List<SubscriptionModel> localList = subscribtionLocalDataSource.get();
      if (localList.isNotEmpty) {
        return right(localList);
      } else {
        List<SubscriptionModel> list = await subscriptionRemoteDataSource.get();
        return right(list);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SubscriptionModel>>> subUser({
    required String gymId,
    required int count,
    required num price,
    required num profits,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      Timestamp endDate = Timestamp.fromDate(
        Timestamp.now().toDate().add(
              const Duration(days: 30),
            ),
      );
      var uuid = const Uuid().v4();
      SubscriberModel model = SubscriberModel(
        uid: uuid,
        userId: uid,
        subDate: Timestamp.now(),
        endDate: endDate,
        paymentMethod: 'Zain Cash',
        price: price,
      );
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(gymId)
          .collection('subscribers')
          .doc(uuid)
          .set(
            model.toJson(),
          );
      await updateGym(gymId: gymId, count: count, profits: profits);
      await addSubUser(uuid, endDate, gymId, price, uid);
      List<SubscriptionModel> list = await subscriptionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SubscriptionModel>>> renewSub({
    required String gymId,
    required String subId,
    required num price,
    required num profits,
    required int count,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      Timestamp endDate = Timestamp.fromDate(
        Timestamp.now().toDate().add(
              const Duration(days: 30),
            ),
      );
      SubscriberModel model = SubscriberModel(
        uid: subId,
        userId: uid,
        subDate: Timestamp.now(),
        endDate: endDate,
        paymentMethod: 'Zain Cash',
        price: price,
      );
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(gymId)
          .collection('subscribers')
          .doc(subId)
          .update(
            model.toJson(),
          );
      updateGym(gymId: gymId, count: count, profits: profits);
      await addSubUser(subId, endDate, gymId, price, uid);
      List<SubscriptionModel> list = await subscriptionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> addSubUser(
    String uuid,
    Timestamp endDate,
    String gymId,
    num price,
    String uid,
  ) async {
    SubscriptionModel sModel = SubscriptionModel(
      uid: uuid,
      subDate: Timestamp.now(),
      endDate: endDate,
      gymId: gymId,
      paymentMethod: 'Zain Cash',
      price: price,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Subscriptions')
        .doc(uuid)
        .set(
          sModel.toJson(),
        );
  }

  Future<void> updateGym({
    required String gymId,
    required int count,
    required num profits,
  }) async {
    await FirebaseFirestore.instance
        .collection('gyms')
        .doc('data')
        .collection('data')
        .doc(gymId)
        .update(
      {
        "subcribersCount": count,
        "profits": profits,
      },
    );
  }
}
