import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/order/domain/repo/order_repo.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit(this.orderRepo) : super(InitialOrderState());
  static OrderCubit get(context) => BlocProvider.of(context);

  final OrderRepo orderRepo;

  void getData() async {
    var result = await orderRepo.getStoreOrders();
    result.fold((message) {
      log(message);
      emit(ErrorGetOrdersState(message));
    }, (list) {
      emit(SuccessGetOrdersState(list));
    });
  }

  void updateOrder({
    required String status,
    required String orderId,
  }) async {
    log(status);
    var result = await orderRepo.updateOrder(status: status, orderId: orderId);
    result.fold((message) {
      emit(ErrorGetOrdersState(message));
    }, (list) {
      emit(SuccessGetOrdersState(list));
    });
  }
}
