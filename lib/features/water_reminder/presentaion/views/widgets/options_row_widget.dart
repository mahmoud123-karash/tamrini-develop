import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/reminder_container_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class OptionsRowWidget extends StatefulWidget {
  const OptionsRowWidget({super.key});

  @override
  State<OptionsRowWidget> createState() => _OptionsRowWidgetState();
}

class _OptionsRowWidgetState extends State<OptionsRowWidget> {
  String isSelected = 'reminder';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ReminderContainerWidget(
            onPressed: () {
              isSelected = 'reminder';
              setState(() {});
            },
            lable: S.of(context).reminder,
            color: isSelected == 'reminder' ? appColor : whiteColor,
            icon: Icons.alarm,
          ),
        ),
        Expanded(
          child: ReminderContainerWidget(
            onPressed: () {
              isSelected = 'history';
              setState(() {});
            },
            lable: S.of(context).history,
            color: isSelected == 'history' ? appColor : whiteColor,
            icon: Icons.history,
          ),
        )
      ],
    );
  }
}
