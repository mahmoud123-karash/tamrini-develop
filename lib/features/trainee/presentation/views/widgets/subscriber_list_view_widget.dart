import 'package:flutter/material.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';

import 'subscriber_item_widget.dart';

class SubscriberListViewWidget extends StatelessWidget {
  const SubscriberListViewWidget({
    super.key,
    required this.list,
    required this.length,
    required this.controller,
    required this.image,
  });
  final List<TraineeModel> list;
  final int length;
  final ScrollController controller;
  final String image;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      itemBuilder: (context, index) {
        if (index < length) {
          return SubscriberItemWidget(
            model: list[index],
            image: image,
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: length < list.length ? length + 1 : list.length,
    );
  }
}
