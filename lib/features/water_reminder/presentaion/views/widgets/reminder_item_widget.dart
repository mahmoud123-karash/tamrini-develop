import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/water_reminder/data/models/reminder_model/reminder_model.dart';
import 'package:tamrini/features/water_reminder/presentaion/manager/reminder_cubit/reminder_cubit.dart';
import 'package:tamrini/features/water_reminder/presentaion/manager/reminder_cubit/reminder_states.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/reminder_bottom_sheet_widget.dart';

class ReminderItemWidget extends StatelessWidget {
  const ReminderItemWidget(
      {super.key, required this.model, required this.index});
  final ReminderModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderCubit, ReminderStates>(
      builder: (context, state) {
        ReminderCubit.get(context).isActive =
            isTimeAfter(model.time) ? model.isActive : false;
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            ReminderCubit.get(context).removeReminder(
              model: model,
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
                    index: index,
                    model: model,
                  ),
                );
              },
              leading: SizedBox(
                height: 40,
                child: Image.asset(Assets.imagesWater),
              ),
              title: Text(
                model.quantiy,
                style: TextStyles.style16Bold.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                model.time.format(context),
                style: TextStyles.style14.copyWith(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: ReminderCubit.get(context).isActive,
                  onChanged: (value) {
                    if (isTimeAfter(model.time)) {
                      ReminderCubit.get(context).isActive = value;
                      ReminderCubit.get(context).updateReminder(
                        oldModel: model,
                        context: context,
                        model: ReminderModel(
                          id: model.id,
                          quantiy: model.quantiy,
                          time: model.time,
                          isActive: value,
                        ),
                      );
                    } else {
                      showReminderBottomSheet(
                        context,
                        ReminderBottomSheetWidget(
                          index: index,
                          model: model,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
