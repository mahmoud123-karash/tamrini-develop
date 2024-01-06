import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class UpdateLocationCustomButtonWidget extends StatelessWidget {
  const UpdateLocationCustomButtonWidget(
      {super.key, required this.lable, required this.onPressed});
  final String lable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: MaterialButton(
        color: appColor.withOpacity(0.7),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            lable,
            style: TextStyles.style17.copyWith(color: whiteColor),
          ),
        ),
      ),
    );
  }
}
