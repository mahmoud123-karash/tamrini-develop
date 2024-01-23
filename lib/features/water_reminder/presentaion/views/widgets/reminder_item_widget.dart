import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/water_reminder/data/models/reminder_model/reminder_model.dart';
import 'package:tamrini/features/water_reminder/presentaion/manager/reminder_cubit/reminder_cubit.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/reminder_bottom_sheet_widget.dart';

class ReminderItemWidget extends StatefulWidget {
  const ReminderItemWidget(
      {super.key, required this.model, required this.index});
  final ReminderModel model;
  final int index;

  @override
  State<ReminderItemWidget> createState() => _ReminderItemWidgetState();
}

class _ReminderItemWidgetState extends State<ReminderItemWidget> {
  late bool isActive;
  @override
  void initState() {
    isActive = isTimeAfter(widget.model.time) ? widget.model.isActive : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        ReminderCubit.get(context).removeReminder(
          index: widget.index,
          context: context,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          onTap: () {
            showReminderBottomSheet(
              context,
              ReminderBottomSheetWidget(
                index: widget.index,
                model: widget.model,
              ),
            );
          },
          leading: SizedBox(
            height: 40,
            child: Image.asset(Assets.imagesWater),
          ),
          title: Text(
            widget.model.quantiy,
            style: TextStyles.style16Bold.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            widget.model.time.format(context),
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
                ReminderCubit.get(context).updateReminder(
                  index: widget.index,
                  context: context,
                  model: ReminderModel(
                    id: widget.model.id,
                    quantiy: widget.model.quantiy,
                    time: widget.model.time,
                    isActive: value,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
