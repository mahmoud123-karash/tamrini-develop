import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/generated/l10n.dart';

class DinarTextWidget extends StatelessWidget {
  const DinarTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      " ${S.of(context).dinar}",
      style: TextStyle(
        fontSize: 12.sp,
      ),
    );
  }
}
