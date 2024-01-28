import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import '../users_screen.dart';
import 'admin_user_container_widget.dart';

class AdminUserRowWidget extends StatelessWidget {
  const AdminUserRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AdminUserContainerWidget(
          lable: S.of(context).writers,
          color: appColor,
          onPressed: () {
            navigateTo(context, UsersScreen(title: S.of(context).writers));
          },
        ),
        const Spacer(),
        AdminUserContainerWidget(
          lable: S.of(context).trainers,
          color: appColor,
          onPressed: () {
            navigateTo(context, UsersScreen(title: S.of(context).trainers));
          },
          icon: Icons.sports_gymnastics_outlined,
        ),
        const Spacer(),
        AdminUserContainerWidget(
          lable: S.of(context).gym_owners,
          color: appColor,
          onPressed: () {
            navigateTo(context, UsersScreen(title: S.of(context).gym_owners));
          },
          icon: Icons.fitness_center_sharp,
        ),
        const Spacer(),
        AdminUserContainerWidget(
          lable: S.of(context).store_owners,
          color: appColor,
          onPressed: () {
            navigateTo(context, UsersScreen(title: S.of(context).store_owners));
          },
          icon: Icons.storefront_outlined,
        ),
      ],
    );
  }
}
