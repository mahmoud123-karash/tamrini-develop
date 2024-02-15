import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/generated/l10n.dart';

class ApplogoAndNameWidget extends StatelessWidget {
  const ApplogoAndNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          "assets/icon/icon.png",
          width: 60.sp,
          height: 60.sp,
        ),
        Text(S.of(context).all_privay_saved),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Tamrini"),
            const Text(" © "),
            Text(DateTime.now().year.toString()),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
