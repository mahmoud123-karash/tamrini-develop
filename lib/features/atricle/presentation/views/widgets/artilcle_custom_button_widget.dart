import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ArticleCustomButtonWidget extends StatelessWidget {
  const ArticleCustomButtonWidget(
      {super.key,
      required this.color,
      required this.lable,
      required this.onPressed});
  final Color color;
  final String lable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          lable,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
