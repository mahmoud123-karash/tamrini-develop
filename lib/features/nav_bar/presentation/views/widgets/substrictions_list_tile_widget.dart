import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/services.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/subscribtions/presentation/views/subscriptions_screen.dart';
import 'package:tamrini/features/nav_bar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SubstrictionsListTileWidget extends StatelessWidget {
  const SubstrictionsListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? "";
    return DrawerListTileWidget(
      onPressed: () {
        if (uid != '') {
          navigateTo(context, const SubscriptionsScreen());
        } else {
          showWaringLoginDialog(context);
        }
      },
      icon: Icons.subscriptions_outlined,
      lable: S.of(context).Subscriptions,
    );
  }
}
