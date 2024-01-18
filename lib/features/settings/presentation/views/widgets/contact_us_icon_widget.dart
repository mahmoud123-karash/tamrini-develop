import 'package:flutter/material.dart';

class ContactUsIconWidget extends StatelessWidget {
  const ContactUsIconWidget(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.color});
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Icon(
        icon,
        size: 25,
        color: color,
      ),
    );
  }
}
