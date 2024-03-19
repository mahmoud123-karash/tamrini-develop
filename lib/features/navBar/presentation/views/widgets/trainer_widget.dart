import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/views/trainer_subscribers_screen.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'drawer_list_tile_widget.dart';

class TrainerWidget extends StatelessWidget {
  const TrainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return BlocBuilder<TrainersCubit, TrainersStates>(
      builder: (context, state) {
        if (state is SucessGetTrainersState) {
          List<TrainerModel> list =
              state.list.where((element) => element.uid == uid).toList();
          TrainerModel trainer = list.first;
          return Column(
            children: [
              DrawerListTileWidget(
                onPressed: () {
                  navigateTo(
                      context,
                      TrainerSubscribersScreen(
                        logo: trainer.logo,
                      ));
                },
                icon: Icons.people_alt_outlined,
                lable: S.of(context).subcribers,
              ),
              DrawerListTileWidget(
                onPressed: () {
                  navigateTo(context, TrainerProfileScreen(id: uid));
                },
                icon: Icons.co_present_outlined,
                lable: S.of(context).trainer_profile,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
