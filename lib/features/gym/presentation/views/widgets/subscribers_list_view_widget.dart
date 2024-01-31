import 'package:flutter/material.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subcribers_item_widget.dart';

class SubscriberListViewWidget extends StatelessWidget {
  const SubscriberListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListView.separated(
        itemBuilder: (context, index) => const SubscribersItemWidget(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: 20,
      ),
    );
  }
}
