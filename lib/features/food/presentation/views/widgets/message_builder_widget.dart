import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class MessageBuilderWidget extends StatelessWidget {
  const MessageBuilderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyles.style17,
        ),
      ),
    );
  }
}
