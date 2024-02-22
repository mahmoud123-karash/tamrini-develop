import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class SubContentWidget extends StatelessWidget {
  const SubContentWidget({super.key, required this.contentHint});
  final String contentHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.amber,
          child: Center(
            child: Icon(
              Icons.done,
              size: 40,
              color: whiteColor,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          contentHint,
          style: TextStyles.style14.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          S.of(context).please_end_to_sub,
          style: TextStyles.style14.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
