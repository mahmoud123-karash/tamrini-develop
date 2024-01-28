import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ProductAddTextWidget extends StatelessWidget {
  const ProductAddTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Text(
        text,
        style: TextStyles.style16Bold.copyWith(
          fontWeight: FontWeight.bold,
          color: appColor,
        ),
      ),
    );
  }
}
