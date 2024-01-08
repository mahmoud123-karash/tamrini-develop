import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleContainerWidget extends StatelessWidget {
  const ArticleContainerWidget({
    super.key,
    required this.image,
    required this.lable,
    required this.onPressed,
  });
  final String image, lable;
  final VoidCallback onPressed;

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
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
