import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  static const TextStyle style20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: 'cairo',
  );

  static TextStyle style14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'cairo',
    color: Colors.black,
  );

  static const TextStyle style20Bold = TextStyle(
    fontFamily: "cairo",
    color: Colors.black87,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
}
