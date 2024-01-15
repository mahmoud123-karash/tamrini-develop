import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_cubit.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_states.dart';
import 'package:tamrini/generated/l10n.dart';

class ThemeListTileWidget extends StatelessWidget {
  const ThemeListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCubit, ManageStates>(
      builder: (context, state) {
        bool isDark = ManageCubit.get(context).isDark;
        return SwitchListTile(
          secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode_rounded),
          title: Text(
            S.of(context).theme,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: isDark,
          onChanged: (value) {
            ManageCubit.get(context).changeAppTheme();
          },
        );
      },
    );
  }
}
