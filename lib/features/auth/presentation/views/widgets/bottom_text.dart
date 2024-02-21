import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class BottomText extends StatelessWidget {
  const BottomText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.onPressed});
  final String text1;
  final String text2;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Montserrat',
            ),
            children: [
              TextSpan(
                text: text1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: text2,
                style: TextStyle(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
