import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';

class ReminderTextFieldWidgt extends StatelessWidget {
  const ReminderTextFieldWidgt({
    super.key,
    required this.controller,
    required this.lable,
    required this.icon,
    required this.autovalidateMode,
    required this.onTap,
  });
  final TextEditingController controller;
  final String lable;
  final IconData icon;
  final AutovalidateMode autovalidateMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      autovalidateMode: autovalidateMode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).validate;
        }
        return null;
      },
      keyboardType: TextInputType.none,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: lable,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: appColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: appColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: appColor,
          ),
        ),
      ),
    );
  }
}
