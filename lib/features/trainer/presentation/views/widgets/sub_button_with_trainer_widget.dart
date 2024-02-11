import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class SubButtonWithTrainerWidget extends StatelessWidget {
  const SubButtonWithTrainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 35,
        color: appColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        onPressed: () {},
        child: Text(
          S.of(context).sub,
          style: TextStyles.style17.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
