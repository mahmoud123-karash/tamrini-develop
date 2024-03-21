import 'package:flutter/material.dart';

class TrainerIconOptionsWidget extends StatelessWidget {
  const TrainerIconOptionsWidget(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.themeColor});
  final VoidCallback onTap;
  final IconData icon;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: themeColor,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
