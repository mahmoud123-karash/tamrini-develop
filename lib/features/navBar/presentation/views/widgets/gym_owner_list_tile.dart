import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/views/gym_owner_screen.dart';
import 'package:tamrini/features/gym/presentation/views/new_gym_screen.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../gym/presentation/manager/gym_cubit/gym_states.dart';

class GymOwnerListTileWidget extends StatelessWidget {
  const GymOwnerListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return BlocBuilder<GymCubit, GymStates>(
      builder: (context, state) {
        if (state is SucessGetGymsState) {
          List<GymModel> list = GymCubit.get(context).getUserGym(uid);
          return DrawerListTileWidget(
            onPressed: () {
              if (list.isEmpty) {
                navigateTo(context, const NewGymScreen());
              } else {
                navigateTo(context, const GymOwnerScreen());
              }
            },
            icon: Icons.fitness_center_outlined,
            lable: S.of(context).gym_owner,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
