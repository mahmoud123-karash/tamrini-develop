import 'package:flutter/material.dart';

import 'my_day_item_widget.dart';

class MyDatListViewWidget extends StatelessWidget {
  const MyDatListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => const MyDayItemWidget(),
      itemCount: 15,
    );
  }
}
