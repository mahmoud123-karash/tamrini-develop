import 'package:flutter/material.dart';

import 'reminder_item_widget.dart';

class ReminderListViewWidget extends StatelessWidget {
  const ReminderListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ListView.separated(
          itemBuilder: (context, index) => const ReminderItemWidget(),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 15,
        ),
      ),
    );
  }
}
