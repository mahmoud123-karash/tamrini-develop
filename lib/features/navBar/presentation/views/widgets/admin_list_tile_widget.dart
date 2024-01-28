import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/admin/presentation/views/admin_screen.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class AdminListTileWidget extends StatelessWidget {
  const AdminListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerListTileWidget(
      onPressed: () {
        navigateTo(context, const AdminScreen());
      },
      icon: Icons.admin_panel_settings_outlined,
      lable: S.of(context).admin_control_pannel,
    );
  }
}
