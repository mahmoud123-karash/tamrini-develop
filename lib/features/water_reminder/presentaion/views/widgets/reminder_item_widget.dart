import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/add_reminder_bottom_sheet_widget.dart';

class ReminderItemWidget extends StatefulWidget {
  const ReminderItemWidget({super.key});

  @override
  State<ReminderItemWidget> createState() => _ReminderItemWidgetState();
}

class _ReminderItemWidgetState extends State<ReminderItemWidget> {
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          onTap: () {
            showReminderBottomSheet(
                context, const AddReminderBottomSheetWidget());
          },
          leading: SizedBox(
            height: 40,
            child: Image.asset(Assets.imagesWater),
          ),
          title: Text(
            '300ml',
            style: TextStyles.style17.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '3:30 Am',
            style: TextStyles.style14.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Transform.scale(
            scale: 0.8,
            child: Switch(
              value: isActive,
              onChanged: (value) {
                isActive = value;
                setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }
}
