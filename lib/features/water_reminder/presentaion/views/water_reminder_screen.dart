import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

class WaterReminderScreen extends StatelessWidget {
  const WaterReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).water_alarm,
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
