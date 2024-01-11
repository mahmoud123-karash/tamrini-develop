import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class AddQuestionTextFieldWidget extends StatelessWidget {
  const AddQuestionTextFieldWidget(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.hint});
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        minLines: 1,
        maxLines: 100,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: hint,
          hintStyle: TextStyles.style16Bold,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
