import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class StoreNumberProductsWidget extends StatelessWidget {
  const StoreNumberProductsWidget({super.key, required this.num});
  final int num;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "${S.of(context).NumProducts}: ",
          style: TextStyles.style17.copyWith(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          num.toString(),
          style: TextStyles.style17.copyWith(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
