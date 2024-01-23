import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';

class ShowGymOnMapWWidget extends StatelessWidget {
  const ShowGymOnMapWWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Text(
                S.of(context).show,
                style: TextStyle(
                  color: blackColor,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
