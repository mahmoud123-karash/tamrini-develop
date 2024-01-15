import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/dialog.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'drawer_list_tile_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      elevation: 0,
      width: width / 1.4,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Intl.getCurrentLocale() == 'ar'
              ? const Radius.circular(60)
              : const Radius.circular(0),
          bottomLeft: Intl.getCurrentLocale() == 'ar'
              ? const Radius.circular(20)
              : const Radius.circular(0),
          bottomRight: Intl.getCurrentLocale() == 'en'
              ? const Radius.circular(20)
              : const Radius.circular(0),
          topRight: Intl.getCurrentLocale() == 'en'
              ? const Radius.circular(60)
              : const Radius.circular(0),
        ),
      ),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Image.asset(
                Assets.imagesLogo,
                width: 130.w,
                height: 130.h,
              ),
              DrawerListTileWidget(
                isSelected: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Ionicons.home_outline,
                lable: S.of(context).home,
              ),
              DrawerListTileWidget(
                onPressed: () {
                  navigateTo(context, const ProfileScreen());
                },
                icon: Ionicons.person_outline,
                lable: S.of(context).profile,
              ),
              DrawerListTileWidget(
                onPressed: () {},
                icon: Ionicons.settings_outline,
                lable: S.of(context).settings,
              ),
              DrawerListTileWidget(
                onPressed: () {},
                icon: Ionicons.information_circle_outline,
                lable: S.of(context).about_app,
              ),
              DrawerListTileWidget(
                onPressed: () {},
                icon: Ionicons.phone_portrait_outline,
                lable: S.of(context).contact_u,
              ),
              DrawerListTileWidget(
                onPressed: () {
                  logOutDialog(context).show();
                },
                icon: Ionicons.log_out_outline,
                lable: S.of(context).log_out,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
