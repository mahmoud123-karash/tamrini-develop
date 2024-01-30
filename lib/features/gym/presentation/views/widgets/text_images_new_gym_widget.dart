import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class TextImagesNewGymWidget extends StatelessWidget {
  const TextImagesNewGymWidget({super.key, required this.lable});
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Text(
        lable,
        style: TextStyles.style17.copyWith(
          fontWeight: FontWeight.bold,
          color: appColor,
        ),
      ),
    );
  }
}
