import 'package:flutter/material.dart';

import '../../../data/models/reminder_model/reminder_model.dart';
import 'reminder_item_widget.dart';

class ReminderListViewWidget extends StatelessWidget {
  const ReminderListViewWidget({super.key, required this.list});
  final List<ReminderModel> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ListView.separated(
          itemBuilder: (context, index) => ReminderItemWidget(
            model: list[index],
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: list.length,
        ),
      ),
    );
  }
}
