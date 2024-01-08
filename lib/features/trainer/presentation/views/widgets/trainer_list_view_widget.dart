import 'package:flutter/material.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_item_widget.dart';

class TrainerListViewWidget extends StatelessWidget {
  const TrainerListViewWidget(
      {super.key, required this.list, required this.length});
  final List<TrainerModel> list;
  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < length) {
          return TrainerItemWidget(
            model: list[index],
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: list.length < length ? list.length : length + 1,
    );
  }
}
