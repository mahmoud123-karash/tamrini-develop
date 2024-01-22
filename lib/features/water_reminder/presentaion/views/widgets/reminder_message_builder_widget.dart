import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ReminderMessageBuilderWidget extends StatelessWidget {
  const ReminderMessageBuilderWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            message,
            style: TextStyles.style16Bold,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
