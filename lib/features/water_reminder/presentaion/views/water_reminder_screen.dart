import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/reminder_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/reminder_bottom_sheet_widget.dart';

class WaterReminderScreen extends StatelessWidget {
  const WaterReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,
        onPressed: () {
          showReminderBottomSheet(
            context,
            const ReminderBottomSheetWidget(index: 0),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: myAppBar(
        S.of(context).water_alarm,
      ),
      body: const ReminderContentWidget(),
    );
  }
}
