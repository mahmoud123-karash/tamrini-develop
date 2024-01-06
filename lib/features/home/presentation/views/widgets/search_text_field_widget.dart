import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget(
      {super.key, required this.controller, required this.onChanged});
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Ionicons.search_outline,
            color: blackColor,
          ),
          hintText: S.of(context).search,
          hintStyle: TextStyle(
            color: blackColor,
            fontWeight: FontWeight.w600,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
