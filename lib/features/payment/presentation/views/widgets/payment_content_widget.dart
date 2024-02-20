import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_states.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/status_builder_widget.dart';
import 'package:tamrini/features/payment/presentation/views/zain_cash_screen.dart';
import 'package:tamrini/generated/l10n.dart';
import 'payment_info_container_widget.dart';

class PaymentContentWidget extends StatefulWidget {
  const PaymentContentWidget({
    super.key,
    required this.transactionId,
    required this.amount,
    required this.id,
    required this.onSuccess,
  });
  final String transactionId, id;
  final num amount;
  final VoidCallback onSuccess;

  @override
  State<PaymentContentWidget> createState() => _PaymentContentWidgetState();
}

class _PaymentContentWidgetState extends State<PaymentContentWidget> {
  bool isNavigate = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  S.of(context).create_payment_uri_success,
                  style: TextStyles.style14.copyWith(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PaymentInfoContainerWidget(amount: widget.amount),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<StatusCubit, StatusStates>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (state is FailedStatusState)
                          Text(
                            state.message,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (state is! SucessStatusState &&
                            state is! FailedStatusState)
                          ElevatedButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                ZainCashScreen(
                                  trasactionId: widget.transactionId,
                                ),
                              );
                              Future.delayed(const Duration(seconds: 5)).then(
                                (value) {
                                  isNavigate = true;
                                  setState(() {});
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                S.of(context).payment_uri,
                                style: TextStyles.style14.copyWith(
                                  color: appColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: isNavigate
                  ? StatusBuilderWidget(
                      trasactionId: widget.transactionId,
                      amount: widget.amount,
                      id: widget.id,
                      onSuccess: widget.onSuccess,
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }
}
