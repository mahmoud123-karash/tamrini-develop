import 'package:dartz/dartz.dart';
import 'package:tamrini/features/subscribtions/data/data_sources/local_data_source/subscribtion_local_data_source.dart';
import 'package:tamrini/features/subscribtions/data/data_sources/remote_data_source/subscribtion_remote_data_source.dart';
import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';
import 'package:tamrini/features/subscribtions/domain/repo/subscription_repo.dart';

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
}
