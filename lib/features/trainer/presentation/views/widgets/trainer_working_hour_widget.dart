import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/title_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerWorkingHourWidget extends StatelessWidget {
  const TrainerWorkingHourWidget(
      {super.key, required this.from, required this.to});
  final String from, to;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TitleTextWidget(lable: S.of(context).work_hour),
        Text(S.of(context).from),
        const Spacer(),
        Text(
          from,
          style: TextStyles.style16Bold.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(S.of(context).to),
        const Spacer(),
        Text(
          to,
          style: TextStyles.style16Bold.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
