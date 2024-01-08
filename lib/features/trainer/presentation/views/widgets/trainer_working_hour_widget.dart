import 'package:flutter/material.dart';
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
        const SizedBox(
          width: 10,
        ),
        Text(from),
        const SizedBox(
          width: 20,
        ),
        Text(S.of(context).to),
        const SizedBox(
          width: 10,
        ),
        Text(to),
      ],
    );
  }
}
