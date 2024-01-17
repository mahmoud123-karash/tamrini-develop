import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodCategoryItemWidget extends StatelessWidget {
  const FoodCategoryItemWidget(
      {super.key,
      required this.onPressed,
      required this.image,
      required this.lable});
  final VoidCallback onPressed;
  final String image, lable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints(
            minHeight: 100.h,
            maxHeight: 200.h,
            maxWidth: double.infinity,
            minWidth: double.infinity,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lable,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
