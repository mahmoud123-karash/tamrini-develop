import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';
import 'package:tamrini/features/promotion/presentation/manager/promotion_cubit/promotion_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class AcceptRefuseButtonWidget extends StatelessWidget {
  const AcceptRefuseButtonWidget({super.key, required this.model});
  final PromotionModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: customButton(
            onPressed: () {
              PromotionCubit.get(context).acceptRefuseRequestpromotion(
                model: model,
                isAccept: true,
                context: context,
              );
            },
            lable: S.of(context).accept,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: customButton(
            color: Colors.red,
            onPressed: () {
              PromotionCubit.get(context).acceptRefuseRequestpromotion(
                model: model,
                isAccept: false,
                context: context,
              );
            },
            lable: S.of(context).refuse,
          ),
        ),
      ],
    );
  }
}
