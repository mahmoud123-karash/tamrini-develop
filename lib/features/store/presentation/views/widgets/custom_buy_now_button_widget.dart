import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class CustomBuyNowButtonWidget extends StatelessWidget {
  const CustomBuyNowButtonWidget(
      {super.key,
      required this.onPressed,
      required this.lable,
      required this.color});
  final VoidCallback onPressed;
  final String lable;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MaterialButton(
      color: color,
      shape: OutlineInputBorder(
        borderSide: BorderSide(
          color: appColor,
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          lable,
          style: TextStyles.style20.copyWith(
            color: color == appColor ? whiteColor : blackColor,
          ),
        ),
      ),
    ));
  }
}
