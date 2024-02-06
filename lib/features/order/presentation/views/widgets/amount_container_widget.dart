import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class AmoutContainerWidget extends StatelessWidget {
  const AmoutContainerWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: appColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
