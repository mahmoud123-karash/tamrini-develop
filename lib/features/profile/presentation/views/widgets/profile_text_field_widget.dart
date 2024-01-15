import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';

class ProfileTextFiledWidget extends StatelessWidget {
  const ProfileTextFiledWidget({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.autovalidateMode,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greyColor.withOpacity(0.2),
      ),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        validator: (value) {
          if (value!.isEmpty) {
            return S.of(context).validate;
          }
          return null;
        },
        keyboardType: keyboardType,
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
