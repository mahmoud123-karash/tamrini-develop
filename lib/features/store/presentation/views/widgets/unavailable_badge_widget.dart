import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class UnAvailableBadgeWidget extends StatelessWidget {
  const UnAvailableBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 100.w,
        height: 30.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              S.of(context).unavailable,
              style: TextStyles.style14.copyWith(
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
