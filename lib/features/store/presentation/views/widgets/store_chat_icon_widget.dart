import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class StoreChatIconWidget extends StatelessWidget {
  const StoreChatIconWidget(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.color});
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: whiteColor,
            size: 15,
          ),
        ),
      ),
    );
  }
}
