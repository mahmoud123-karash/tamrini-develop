import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/favourite/presentation/views/favorite_screen.dart';
import 'package:tamrini/features/my_day/presentation/views/my_day_screen.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/gym_owner_list_tile.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/substrictions_list_tile_widget.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/trainer_widget.dart';
import 'package:tamrini/features/order/presentation/views/orders_screen.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/settings/presentation/views/app_settings_screen.dart';
import 'package:tamrini/features/settings/presentation/views/contact_us_screen.dart';
import 'package:tamrini/features/settings/presentation/views/settings_screen.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/water_reminder_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/admin_list_tile_widget.dart';
import 'widgets/drawer_list_tile_widget.dart';
import 'widgets/store_owner_widget.dart';
import 'widgets/trainering_course_list_tile_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    String usertype = CacheHelper.getData(key: 'usertype');
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            if (usertype == UserType.user) const TrainingCourseListTileWidget(),
            if (usertype == UserType.trainer) const TrainerWidget(),
            if (usertype == UserType.admin) const AdminListTileWidget(),
            if (usertype == UserType.admin || usertype == UserType.storeOwner)
              const StoreOwnerWidget(),
            if (usertype == UserType.gymOwner) const GymOwnerListTileWidget(),
            if (usertype != UserType.admin && usertype != UserType.gymOwner)
              const SubstrictionsListTileWidget(),
            if (usertype != UserType.admin && usertype != UserType.storeOwner)
              DrawerListTileWidget(
                onPressed: () {
                  navigateTo(context, const OrdersScreen(isUser: true));
                },
                icon: Icons.shopping_bag_outlined,
                lable: S.of(context).buy_orders,
              ),
            DrawerListTileWidget(
              onPressed: () {
                navigateTo(context, const FavoriteScreen());
              },
              icon: Ionicons.heart_outline,
              lable: S.of(context).favorite_meals,
            ),
            DrawerListTileWidget(
              onPressed: () {
                navigateTo(context, const MyDayScreen());
              },
              icon: Ionicons.calendar_outline,
              lable: S.of(context).my_day,
            ),
            DrawerListTileWidget(
              onPressed: () {
                navigateTo(context, const WaterReminderScreen());
              },
              icon: Ionicons.alarm_outline,
              lable: S.of(context).water_alarm,
            ),
            DrawerListTileWidget(
              onPressed: () {
                navigateTo(context, const SettingsScreen());
              },
              icon: Ionicons.settings_outline,
              lable: S.of(context).settings,
            ),
            DrawerListTileWidget(
              onPressed: () {
                navigateTo(context, const AppSettingsScreen());
              },
              icon: Ionicons.phone_portrait_outline,
              lable: S.of(context).app,
            ),
            DrawerListTileWidget(
              onPressed: () {
                navigateTo(context, const ContactUsScreen());
              },
              icon: Ionicons.call_outline,
              lable: S.of(context).contact_u,
            ),
            DrawerListTileWidget(
              onPressed: () {
                logOutDialog(context).show();
              },
              icon: Ionicons.log_out_outline,
              lable: S.of(context).log_out,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
