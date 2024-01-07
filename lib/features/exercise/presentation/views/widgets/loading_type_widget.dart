import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamrini/core/contants/constants.dart';

class LoadingTypeWidget extends StatelessWidget {
  const LoadingTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [greyColor, appColor],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 100.h,
          decoration: BoxDecoration(
            color: appColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
