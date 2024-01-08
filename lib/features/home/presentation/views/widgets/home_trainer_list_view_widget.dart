import 'package:flutter/material.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

import 'home_trainer_item_widget.dart';

class HomeTrainerListViewWidget extends StatelessWidget {
  const HomeTrainerListViewWidget({super.key, required this.list});
  final List<TrainerModel> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          padding: const EdgeInsets.all(0),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              HomeTrainerItemWidget(model: list[index]),
          separatorBuilder: (context, index) => const SizedBox(
            width: 30,
          ),
          itemCount: list.length > 5 ? 5 : list.length,
        ),
      ),
    );
  }
}
