import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/gym_item_widget.dart';

class GymListViewWidget extends StatelessWidget {
  const GymListViewWidget(
      {super.key,
      required this.list,
      required this.length,
      required this.controller});
  final List<GymModel> list;
  final int length;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return ListView.separated(
      itemCount: list.length > length ? length + 1 : list.length,
      controller: controller,
      itemBuilder: (context, index) {
        if (index < length) {
          return GymItemWidget(
            width: getWidht,
            model: list[index],
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 20,
        );
      },
    );
  }
}
