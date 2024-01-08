import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/presentation/views/widgets/title_and_more_button_row_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_trainer_list_view_widget.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/trainers_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerHomeWidget extends StatelessWidget {
  const TrainerHomeWidget({super.key, required this.list});
  final List<TrainerModel> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleAndMoreButtonRowWidget(
          lable: S.of(context).top_trainers,
          onPressed: () {
            navigateTo(context, const TrainersScreen());
          },
        ),
        const SizedBox(
          height: 10,
        ),
        HomeTrainerListViewWidget(list: list),
        const Divider(
          height: 50,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
