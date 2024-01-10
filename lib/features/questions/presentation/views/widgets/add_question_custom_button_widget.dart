import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class AddQuestionCustomButtonWidget extends StatelessWidget {
  const AddQuestionCustomButtonWidget(
      {super.key,
      required this.controller,
      required this.lable,
      required this.onPressed});
  final TextEditingController controller;
  final String lable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Intl.getCurrentLocale() == 'en'
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      child: MaterialButton(
        color: appColor.withOpacity(0.7),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        onPressed: onPressed,
        child: Text(
          lable,
          style: TextStyles.style14.copyWith(
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
