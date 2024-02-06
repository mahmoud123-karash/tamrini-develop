import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class InputAddressFieldWidget extends StatelessWidget {
  const InputAddressFieldWidget({
    super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    required this.lable,
    required this.autovalidateMode,
  });
  final TextEditingController controller;
  final TextInputType textInputType;
  final String lable;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      controller: controller,
      keyboardType: textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).validate;
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        labelText: lable,
        labelStyle: TextStyles.style16Bold.copyWith(
          fontWeight: FontWeight.bold,
          color: greyColor.withOpacity(
            0.5,
          ),
        ),
      ),
    );
  }
}
