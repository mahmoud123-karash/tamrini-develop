import 'package:flutter/material.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriber_item_builder_widget.dart';

import '../../../data/models/subscriber_model/subscriber_model.dart';

class SubscriberListViewWidget extends StatelessWidget {
  const SubscriberListViewWidget({super.key, required this.list});
  final List<SubscriberModel> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListView.separated(
        itemBuilder: (context, index) => SubscriberItemBuilderWidget(
          model: list[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: list.length,
      ),
    );
  }
}
