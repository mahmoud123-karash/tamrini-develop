import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/gym_owner_screen.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class GymOwnerListTileWidget extends StatelessWidget {
  const GymOwnerListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerListTileWidget(
      onPressed: () {
        navigateTo(context, const GymOwnerScreen());
      },
      icon: Icons.fitness_center_outlined,
      lable: S.of(context).gym_owner,
    );
  }
}
