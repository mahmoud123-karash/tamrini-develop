import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/auto_reminder_list_tile_widget.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/reminder_list_view_builder_widget.dart';

class ReminderContentWidget extends StatelessWidget {
  const ReminderContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(
          color: greyColor.withOpacity(0.2),
          thickness: 5,
        ),
        const AutoRemiderListTileWidget(),
        Divider(
          color: greyColor.withOpacity(0.2),
          thickness: 5,
        ),
        const ReminderListViewBuilderWidget(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
