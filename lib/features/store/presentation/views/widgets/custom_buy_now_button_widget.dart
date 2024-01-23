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
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: color != appColor ? blackColor : appColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                lable,
                style: TextStyles.style20.copyWith(
                  color: color == appColor ? whiteColor : blackColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
