import 'package:flutter/material.dart';

class TrainerIconOptionsWidget extends StatelessWidget {
  const TrainerIconOptionsWidget(
      {super.key, required this.onTap, required this.icon});
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          child: Icon(icon),
        ),
      ),
    );
  }
}
