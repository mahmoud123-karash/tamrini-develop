import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/domain/repo/order_repo.dart';
import 'package:tamrini/features/order/presentation/manager/user_order_cubit/user_order_states.dart';
import 'package:tamrini/features/rating/presentation/views/product_rating_screen.dart';

class UserOrderCubit extends Cubit<UserOrderStates> {
  UserOrderCubit(this.orderRepo) : super(InitialUserOrderState());
  static UserOrderCubit get(context) => BlocProvider.of(context);

  final OrderRepo orderRepo;

  void getData() async {
    emit(LoadingGetUserOrderState());
    var result = await orderRepo.getUserOrders();
    result.fold((message) {
      emit(ErrorGetUserOrderState(message));
    }, (list) {
      emit(SuccessGetUserOrderState(list));
    });
  }

  void makeOrder({
    required String address,
    required String storeId,
    required String name,
    required String phone,
    required Product product,
  }) async {
    emit(LoadingGetUserOrderState());
    var result = await orderRepo.makeOrder(
      address: address,
      storeId: storeId,
      name: name,
      phone: phone,
      product: product,
    );
    result.fold((message) {
      emit(ErrorGetUserOrderState(message));
    }, (list) {
      emit(SuccessGetUserOrderState(list));
    });
  }

  void updateOrder({
    required String status,
    required String orderId,
    required String stroreId,
    required Product model,
    required BuildContext context,
  }) async {
    var result = await orderRepo.userReciededOrder(
      status: status,
      orderId: orderId,
      stroreId: stroreId,
      totalPrice: model.price * model.quantity,
    );
    result.fold((message) {
      log(message);
      emit(ErrorGetUserOrderState(message));
    }, (list) {
      navigateToAndReplace(context, ProductRatingScreen(model: model));
      emit(SuccessGetUserOrderState(list));
    });
  }
}
