import 'package:flutter/material.dart';

import 'reminder_item_widget.dart';

class ReminderListViewWidget extends StatelessWidget {
  const ReminderListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => const ReminderItemWidget(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: 15,
      ),
    );
  }
}
