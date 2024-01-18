import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';

class CalculatorContainerWidget extends StatelessWidget {
  const CalculatorContainerWidget({
    super.key,
    required this.cardChild,
    required this.onPress,
    required this.colory,
  });
  final Color colory;
  final Widget cardChild;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 150.sp,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colory,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: appColor,
          ),
        ),
        child: cardChild,
      ),
    );
  }
}
