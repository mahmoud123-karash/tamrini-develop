import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/gym_item_widget.dart';

class GymListViewWidget extends StatelessWidget {
  const GymListViewWidget({super.key, required this.models});
  final List<GymModel> models;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: models.length > 5 ? 5 : models.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GymItemWidget(
          width: getWidht,
          model: models[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}
