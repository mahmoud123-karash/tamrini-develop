import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/presentation/views/summary_order_screen.dart';
import 'package:tamrini/features/payment/domain/use_cases/create_transaction_id_use_case.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_states.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_cubit.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/payment_content_widget.dart';
import 'widgets/payment_error_builder_widget.dart';

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
    num amount = model.price * model.quantity;
    return BlocProvider(
      create: (context) => PaymentCubit(
        getIt.get<CreateTranscationIdUseCase>(),
      )..createTransactionId(
          amount: amount,
          orderId: model.id,
        ),
      child: BlocProvider(
        create: (context) => StatusCubit(
          getIt.get<CreateTranscationIdUseCase>(),
        ),
        child: Scaffold(
          appBar: myAppBar(S.of(context).payment),
          body: BlocBuilder<PaymentCubit, PaymentStates>(
            builder: (context, state) {
              if (state is SucessCreateTransactionIdState) {
                if (state.id != null) {
                  return PaymentContentWidget(
                    transactionId: state.id!,
                    amount: amount,
                    id: model.id,
                    onSuccess: () {
                      navigateTo(
                        context,
                        SummaryOrderScreen(
                          model: model,
                          name: name,
                          phone: phone,
                          address: address,
                          storeId: storeId,
                        ),
                      );
                    },
                  );
                } else {
                  return PaymentErrorBuilderWidget(
                    message: S.of(context).error_payment,
                    id: model.id,
                    amount: amount,
                  );
                }
              } else if (state is ErrorCreateTransactionIdState) {
                return PaymentErrorBuilderWidget(
                  message: state.message,
                  id: model.id,
                  amount: amount,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
