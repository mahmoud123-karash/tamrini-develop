import 'package:flutter/material.dart';

class MessageDietFoodWidget extends StatelessWidget {
  const MessageDietFoodWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
