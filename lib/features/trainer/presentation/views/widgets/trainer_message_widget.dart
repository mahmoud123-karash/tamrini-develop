import 'package:flutter/material.dart';

class TrainerMessageWidget extends StatelessWidget {
  const TrainerMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
