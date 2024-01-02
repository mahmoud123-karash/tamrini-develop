import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class MessageTextWidget extends StatelessWidget {
  const MessageTextWidget(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: appColor,
          decorationStyle: TextDecorationStyle.solid,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'cairo',
        ),
      ),
    );
  }
}
