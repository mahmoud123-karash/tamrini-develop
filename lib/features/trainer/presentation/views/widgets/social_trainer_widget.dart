import 'package:flutter/material.dart';

class SocialTrainerWidget extends StatelessWidget {
  const SocialTrainerWidget(
      {super.key,
      required this.icon,
      required this.color,
      required this.onPressed});
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Icon(
        icon,
        color: color,
        size: 25,
      ),
    );
  }
}
