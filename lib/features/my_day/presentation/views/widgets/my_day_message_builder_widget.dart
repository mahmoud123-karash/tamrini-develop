import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class MyDayMessageBuilderWidget extends StatelessWidget {
  const MyDayMessageBuilderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Text(
          message,
          style: TextStyles.style16Bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
