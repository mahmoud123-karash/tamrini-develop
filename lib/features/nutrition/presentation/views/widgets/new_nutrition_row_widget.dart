import 'package:flutter/material.dart';

class NewNutritionRowWidget extends StatelessWidget {
  const NewNutritionRowWidget({super.key, required this.textField});
  final Widget textField;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.fastfood_rounded),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: textField,
          ),
        ],
      ),
    );
  }
}
