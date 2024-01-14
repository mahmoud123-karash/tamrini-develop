import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ProfileMessageBuilderWidget extends StatelessWidget {
  const ProfileMessageBuilderWidget({super.key, required this.message});
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
