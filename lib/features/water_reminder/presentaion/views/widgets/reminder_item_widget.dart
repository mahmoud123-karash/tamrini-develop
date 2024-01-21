import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/styles/text_styles.dart';

import 'add_reminder_bottom_sheet_widget.dart';

class ReminderItemWidget extends StatelessWidget {
  const ReminderItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appColor.withOpacity(0.1),
          ),
          child: ListTile(
            leading: Image.asset(Assets.imagesWater),
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
            trailing: Container(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: appColor.withOpacity(0.2),
              ),
              child: IconButton(
                onPressed: () {
                  showReminderBottomSheet(
                    context,
                    const AddReminderBottomSheetWidget(),
                  );
                },
                icon: const Icon(
                  Icons.edit_outlined,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
