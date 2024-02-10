import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class PromotionNameRowWidget extends StatelessWidget {
  const PromotionNameRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.stars,
          color: Colors.amber,
          size: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          S.of(context).promotion_to,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
