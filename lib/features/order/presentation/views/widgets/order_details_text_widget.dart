import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class OrderDetailsTextWidget extends StatelessWidget {
  const OrderDetailsTextWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyles.style17.copyWith(
          fontWeight: FontWeight.bold,
          color: appColor,
        ),
      ),
    );
  }
}
