import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/views/trainer_subscribers_screen.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'drawer_list_tile_widget.dart';

class TrainerWidget extends StatelessWidget {
  const TrainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return Column(
      children: [
        DrawerListTileWidget(
          onPressed: () {
            navigateTo(context, const TrainerSubscribersScreen());
          },
          icon: Icons.people_alt_outlined,
          lable: S.of(context).subcribers,
        ),
        BlocBuilder<TrainersCubit, TrainersStates>(
          builder: (context, state) {
            if (state is SucessGetTrainersState) {
              return DrawerListTileWidget(
                onPressed: () {
                  navigateTo(context, TrainerProfileScreen(id: uid));
                },
                icon: Icons.co_present_outlined,
                lable: S.of(context).trainer_profile,
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
