import 'package:flutter/material.dart';

class OptionTabWidget extends StatelessWidget {
  const OptionTabWidget(
      {super.key,
      required this.color,
      required this.icon,
      required this.onPressed});
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(50),
          color: color.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(icon),
        ),
      ),
    );
  }
}
