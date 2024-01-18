import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderColumnWidget extends StatelessWidget {
  const GenderColumnWidget({
    super.key,
    required this.icony,
    required this.texty,
    required this.colory,
  });

  final IconData icony;
  final String texty;
  final Color colory;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icony,
          size: 40.sp,
          color: colory,
        ),
        Text(
          texty,
          style: TextStyle(
            color: colory,
          ),
        ),
      ],
    );
  }
}
