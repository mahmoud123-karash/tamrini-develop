import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class PromotionTypeWidget extends StatelessWidget {
  const PromotionTypeWidget({super.key, required this.promotionType});
  final String promotionType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          S.of(context).promotion_to,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          promotionType,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        )
      ],
    );
  }
}
