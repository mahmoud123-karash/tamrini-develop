import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class NotificationMessageBuilderWidget extends StatelessWidget {
  const NotificationMessageBuilderWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          message,
          style: TextStyles.style17,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
