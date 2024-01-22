import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/water_reminder/data/repo/reminder_repo_impl.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/remider_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/reminder_cubit/reminder_cubit.dart';
import 'widgets/add_reminder_bottom_sheet_widget.dart';

class WaterReminderScreen extends StatelessWidget {
  const WaterReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReminderCubit(
        getIt.get<ReminderRepoImpl>(),
      )..getData(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: appColor,
          onPressed: () {
            showReminderBottomSheet(
              context,
              const AddReminderBottomSheetWidget(),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: myAppBar(
          S.of(context).water_alarm,
        ),
        body: const ReminderContentWidget(),
      ),
    );
  }
}
