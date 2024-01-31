import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

import 'sub_end_date_row_widget.dart';
import 'subscriber_row_widget.dart';

class SubscribersItemWidget extends StatelessWidget {
  const SubscribersItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColor.withOpacity(0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SudscriberRowWidget(),
              Divider(
                color: blackColor,
              ),
              const SubEndDateRowWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
