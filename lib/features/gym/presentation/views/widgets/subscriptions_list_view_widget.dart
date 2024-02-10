import 'package:flutter/material.dart';
import 'package:tamrini/core/models/subscription_model/subscription_model.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/ended_subed_row_widget.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscription_item_builder_widget.dart';

class SubscriptionsListViewWidget extends StatelessWidget {
  const SubscriptionsListViewWidget({super.key, required this.list});
  final List<SubscriptionModel> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EndedSubedRowWidget(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) => SubscriptionItemBuilderWidget(
                model: list[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: list.length,
            ),
          ),
        ),
      ],
    );
  }
}
