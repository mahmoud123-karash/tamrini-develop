import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GymDistanceWidget extends StatelessWidget {
  const GymDistanceWidget({super.key, required this.distance});
  final double distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/distance.png',
            width: 18.sp,
            // color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${distance.toPrecision(0)}km',
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
