import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/water_reminder/presentaion/manager/reminder_cubit/reminder_cubit.dart';
import 'package:tamrini/features/water_reminder/presentaion/manager/reminder_cubit/reminder_states.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/remiders_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'reminder_message_builder_widget.dart';

class ReminderListViewBuilderWidget extends StatelessWidget {
  const ReminderListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderCubit, ReminderStates>(
      builder: (context, state) {
        if (state is SucessGetRemindersState) {
          if (state.list.isEmpty) {
            return ReminderMessageBuilderWidget(
              message: S.of(context).no_results,
            );
          }
          return ReminderListViewWidget(list: state.list);
        } else if (state is ErrorGetRemindersState) {
          return ReminderMessageBuilderWidget(message: state.message);
        } else {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
