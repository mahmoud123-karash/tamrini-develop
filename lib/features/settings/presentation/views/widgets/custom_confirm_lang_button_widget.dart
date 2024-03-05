import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class CustomConfirmLangButtonWidget extends StatelessWidget {
  const CustomConfirmLangButtonWidget({super.key, required this.lang});
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: MaterialButton(
        color: appColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        onPressed: () {
          ManageCubit.get(context).changeLanguage(
            language: lang,
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              S.of(context).confirm_lang,
              style: TextStyles.style17.copyWith(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
