import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/views/gym_owner_screen.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../gym/presentation/manager/gym_cubit/gym_states.dart';

class GymOwnerListTileWidget extends StatelessWidget {
  const GymOwnerListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymCubit, GymStates>(
      builder: (context, state) {
        if (state is SucessGetGymsState) {
          return DrawerListTileWidget(
            onPressed: () {
              navigateTo(context, const GymOwnerScreen());
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
