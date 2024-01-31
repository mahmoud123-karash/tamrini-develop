import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class GymContainerInfoWidget extends StatelessWidget {
  const GymContainerInfoWidget({
    super.key,
    required this.onPressed,
    required this.lable,
    required this.icon,
    required this.color,
    required this.value,
  });
  final VoidCallback onPressed;
  final String lable, value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: whiteColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (value != '')
                    Text(
                      value,
                      style: TextStyles.style13.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  Text(
                    lable,
                    style: TextStyles.style13.copyWith(
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
