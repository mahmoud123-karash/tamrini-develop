import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tamrini/features/order/presentation/manager/user_order_cubit/user_order_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class OrderStepperDetailsWidget extends StatelessWidget {
  const OrderStepperDetailsWidget({
    super.key,
    required this.status,
    required this.storeId,
    required this.userId,
    required this.orderId,
    required this.model,
  });
  final String status, storeId, userId, orderId;
  final Product model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: appColor,
        ),
      ),
      child: Stepper(
        currentStep: getStep(status: status),
        controlsBuilder: (context, details) {
          return storeId == uid && getStep(status: status) < 2
              ? ButtonWidget(
                  onPressed: () {
                    if (getStep(status: status) == 2) {
                      return;
                    } else {
                      OrderCubit.get(context).updateOrder(
                        status: status == 'Pending' ? 'Completed' : 'Received',
                        orderId: orderId,
                      );
                    }
                  },
                )
              : userId == uid && getStep(status: status) == 2
                  ? ButtonWidget(
                      onPressed: () {
                        if (getStep(status: status) == 3) {
                          return;
                        } else {
                          UserOrderCubit.get(context).updateOrder(
                            status: 'Delivered',
                            orderId: orderId,
                            stroreId: storeId,
                            model: model,
                            context: context,
                          );
                        }
                      },
                    )
                  : Container();
        },
        steps: [
          Step(
            state: getStep(status: status) > 0
                ? StepState.complete
                : StepState.indexed,
            isActive: getStep(status: status) >= 0,
            title: Text(S.of(context).pending),
            content: Text(S.of(context).pending_message),
          ),
          Step(
            state: getStep(status: status) > 1
                ? StepState.complete
                : StepState.indexed,
            isActive: getStep(status: status) >= 1,
            title: Text(S.of(context).completed),
            content: Text(S.of(context).completed_message),
          ),
          Step(
            state: getStep(status: status) > 2
                ? StepState.complete
                : StepState.indexed,
            isActive: getStep(status: status) >= 2,
            title: Text(S.of(context).received),
            content: Text('${S.of(context).delivered_message}!'),
          ),
          Step(
            state: getStep(status: status) == 3
                ? StepState.complete
                : StepState.indexed,
            isActive: getStep(status: status) == 3,
            title: Text(S.of(context).delivered),
            content: Text(S.of(context).delivered_message),
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(S.of(context).done),
    );
  }
}

String getStatus({required int step}) {
  if (step == 1) {
    return 'Completed';
  } else if (step == 2) {
    return 'Received';
  } else {
    return 'Delivered';
  }
}

int getStep({
  required String status,
}) {
  if (status == 'Pending') {
    return 0;
  } else if (status == 'Completed') {
    return 1;
  } else if (status == 'Received') {
    return 2;
  } else if (status == 'Delivered') {
    return 3;
  } else {
    return 0;
  }
}
