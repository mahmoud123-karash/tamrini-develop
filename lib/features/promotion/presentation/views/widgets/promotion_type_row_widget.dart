import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class PromotionTypeRowWidget extends StatelessWidget {
  const PromotionTypeRowWidget(
      {super.key, required this.lable, required this.icon});
  final String lable;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: appColor,
          size: 25,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          lable,
          style: TextStyles.style16Bold.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        ),
      ],
    );
  }
}
