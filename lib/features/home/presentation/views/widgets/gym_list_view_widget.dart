import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/gym_item_widget.dart';

class GymListViewWidget extends StatelessWidget {
  const GymListViewWidget({super.key, required this.models});
  final List<GymModel> models;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;

    return SizedBox(
      height: getHeight * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: models.length > 5 ? 5 : models.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GymItemWidget(
            width: getWidht - 70,
            model: models[index],
          );
        },
      ),
    );
  }
}
