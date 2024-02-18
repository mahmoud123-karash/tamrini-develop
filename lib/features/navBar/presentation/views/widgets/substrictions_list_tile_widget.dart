import 'package:flutter/material.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/subscribtions/presentation/views/subscriptions_screen.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SubstrictionsListTileWidget extends StatelessWidget {
  const SubstrictionsListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerListTileWidget(
      onPressed: () {
        navigateTo(context, const SubscriptionsScreen());
      },
      icon: Icons.subscriptions_outlined,
      lable: S.of(context).Subscriptions,
    );
  }
}
