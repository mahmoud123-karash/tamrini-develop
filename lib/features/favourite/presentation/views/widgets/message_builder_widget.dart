import 'package:flutter/material.dart';

class MessageBuilderWidget extends StatelessWidget {
  const MessageBuilderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
