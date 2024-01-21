import 'package:flutter/material.dart';

import '../../../data/models/day_model/day_model.dart';
import 'my_day_item_widget.dart';

class MyDayListViewWidget extends StatelessWidget {
  const MyDayListViewWidget({super.key, required this.list});
  final List<DayModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => MyDayItemWidget(model: list[index]),
      itemCount: list.length,
    );
  }
}
