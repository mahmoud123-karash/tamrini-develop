import 'package:dartz/dartz.dart';
import 'package:tamrini/features/order/data/data_sources/remote_data_source/order_remote_data_source.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/features/order/domain/repo/order_repo.dart';

class OrederRepoImpl extends OrderRepo {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrederRepoImpl(this.orderRemoteDataSource);
  @override
  Future<Either<String, List<OrderModel>>> getOrders() async {
    try {
      List<OrderModel> list = await orderRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
