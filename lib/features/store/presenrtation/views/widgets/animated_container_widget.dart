import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class AnimatedContainerWidget extends StatelessWidget {
  const AnimatedContainerWidget(
      {super.key,
      required this.lable,
      required this.onPressed,
      required this.color,
      required this.textColor});
  final String lable;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        width: getWidht / 2 - 20,
        duration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color == appColor ? appColor : Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              lable,
              style: TextStyles.style16Bold.copyWith(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
