import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/presentation/views/suggest_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class SuggestCustomButtonWidget extends StatelessWidget {
  const SuggestCustomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
      color: appColor,
      onPressed: () {
        navigateTo(context, const SuggestScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Text(
          S.of(context).suggest,
          style: TextStyles.style20.copyWith(
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
