import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/awesome_notification.dart';
import 'package:tamrini/core/utils/lists.dart';
import 'package:tamrini/generated/l10n.dart';

import 'auto_reminder_dialog_content_widget.dart';

class AutoRemiderListTileWidget extends StatefulWidget {
  const AutoRemiderListTileWidget({super.key});

  @override
  State<AutoRemiderListTileWidget> createState() =>
      _AutoRemiderListTileWidgetState();
}

class _AutoRemiderListTileWidgetState extends State<AutoRemiderListTileWidget> {
  FixedExtentScrollController? controller;
  late int selectedTime;
  late String selectedItem;
  late bool isActive;

  @override
  void initState() {
    controller = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    selectedTime = CacheHelper.getData(key: 'selectedTime') ?? 0;
    selectedItem = times(context)[selectedTime];
    isActive = CacheHelper.getData(key: 'isActive') ?? false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      onTap: () {
        showReminderDialog(
          child: AutoReminderDialogContentWidget(
            onPressed: () {
              isActive = true;
              saveIsActive(true);
              saveTime(selectedTime);
              setAutoReminder(context);
              Navigator.pop(context);
              setState(() {});
            },
            onSelectedItemChanged: (selected) {
              selectedTime = selected;
              selectedItem = times(context)[selected];
            },
            scrollController: controller!,
          ),
          controller: controller!,
          context: context,
          selectedItem: selectedTime,
        );
      },
      title: Text(
        selectedItem,
        style: TextStyles.style17.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        S.of(context).auto_reminder,
        style: TextStyles.style14.copyWith(
          color: appColor.withOpacity(0.5),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.9,
        child: Switch(
          value: isActive,
          onChanged: (value) {
            isActive = value;
            saveIsActive(value);
            if (value) {
              setAutoReminder(context);
            } else {
              cancelNotification(id: 200000);
            }
            setState(() {});
          },
        ),
      ),
    );
  }

  void setAutoReminder(BuildContext context) {
    int seconds = 0;
    if (selectedTime == 0) {
      seconds = 30 * 60;
    } else {
      seconds = selectedTime * 60 * 60;
    }
    setRepedtedNotification(
      secondes: seconds,
      title: S.of(context).reminder_to_drink,
    );
  }
}
