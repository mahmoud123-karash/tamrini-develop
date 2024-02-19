import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/payment/domain/use_cases/create_transaction_id_use_case.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_states.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/payment_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:zaincash/zaincash.dart';

import 'widgets/buy_success_payment_widget.dart';
import 'widgets/payment_content_widget.dart';

class BuyPaymentScreen extends StatelessWidget {
  const BuyPaymentScreen({
    Key? key,
    required this.model,
    required this.name,
    required this.phone,
    required this.address,
    required this.storeId,
  }) : super(key: key);
  final Product model;
  final String name, phone, address, storeId;

  @override
  Widget build(BuildContext context) {
    ZaincashService.paymentStateListener.listen((state) {
      if (state['success'] == 1) {}
      if (state['success'] == 0) {}
    });

    num amount = model.price * model.quantity;
    return BlocProvider(
      create: (context) => PaymentCubit(
        getIt.get<CreateTranscationIdUseCase>(),
      )..createTransactionId(
          amount: amount,
          orderId: model.id,
        ),
      child: Scaffold(
        appBar: myAppBar(S.of(context).payment),
        body: BlocBuilder<PaymentCubit, PaymentStates>(
          builder: (context, state) {
            if (state is SucessCreateTransactionIdState) {
              return PaymentContentWidget(
                transactionId: state.token,
                amount: amount,
                id: model.id,
              );
            } else if (state is SucessPaymentState) {
              return BuySuccessPaymentWidget(
                model: model,
                name: name,
                phone: phone,
                address: address,
                storeId: storeId,
              );
            } else if (state is ErrorCreateTransactionIdState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    PaymentCustomButtonWidget(
                      amount: amount,
                      id: model.id,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
