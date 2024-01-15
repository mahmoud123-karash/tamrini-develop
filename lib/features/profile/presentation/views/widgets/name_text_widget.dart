import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class NameTextWidget extends StatelessWidget {
  const NameTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyles.style16Bold.copyWith(
          color: appColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
