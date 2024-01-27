import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class AnimatedContainerNotificaionWidget extends StatelessWidget {
  const AnimatedContainerNotificaionWidget({
    super.key,
    required this.lable,
    required this.onPressed,
    required this.isSelected,
    required this.length,
  });
  final String lable;
  final VoidCallback onPressed;
  final bool isSelected;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            decoration: BoxDecoration(
              color: isSelected ? appColor : whiteColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected ? appColor : blackColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lable,
                    style: TextStyles.style12.copyWith(
                      color: isSelected ? whiteColor : blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 2),
                  if (length != 0)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 3,
                        ),
                        child: Text(
                          length > 10 ? "10+" : length.toString(),
                          style: TextStyles.style12.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
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
