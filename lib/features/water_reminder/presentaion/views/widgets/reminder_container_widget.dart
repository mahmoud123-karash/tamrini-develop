import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ReminderContainerWidget extends StatelessWidget {
  const ReminderContainerWidget({
    super.key,
    required this.lable,
    required this.color,
    required this.icon,
    required this.onPressed,
  });
  final String lable;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color == appColor ? appColor : blackColor,
            ),
            color: color == appColor
                ? appColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          duration: const Duration(milliseconds: 700),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lable,
                  style: TextStyles.style14.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color == appColor ? whiteColor : blackColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  icon,
                  color: color == appColor ? whiteColor : blackColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
