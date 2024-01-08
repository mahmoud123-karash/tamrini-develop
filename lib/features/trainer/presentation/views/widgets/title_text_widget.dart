import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({super.key, required this.lable});
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        lable,
        style: TextStyles.style14.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
