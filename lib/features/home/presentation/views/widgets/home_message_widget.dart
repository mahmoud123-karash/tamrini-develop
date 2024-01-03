import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class HomeMessageWidget extends StatelessWidget {
  const HomeMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          message,
          style: TextStyles.style20Bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
