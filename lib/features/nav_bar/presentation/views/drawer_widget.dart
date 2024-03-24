import 'widgets/admin_list_tile_widget.dart';
import 'widgets/drawer_list_tile_widget.dart';
import 'widgets/store_owner_widget.dart';
import 'widgets/trainering_course_list_tile_widget.dart';
import 'package:tamrini/core/utils/improts.dart';
import 'package:intl/intl.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    String usertype = CacheHelper.getData(key: 'usertype') ?? '';
    String uid = CacheHelper.getData(key: 'uid') ?? "";
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
                if (uid != '') {
                  navigateTo(context, const ProfileScreen());
                } else {
                  showWaringLoginDialog(context);
                }
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
                  if (uid != '') {
                    navigateTo(context, const OrdersScreen(isUser: true));
                  } else {
                    showWaringLoginDialog(context);
                  }
                },
                icon: Icons.shopping_bag_outlined,
                lable: S.of(context).buy_orders,
              ),
            DrawerListTileWidget(
              onPressed: () {
                if (uid != '') {
                  navigateTo(context, const FavoriteScreen());
                } else {
                  showWaringLoginDialog(context);
                }
              },
              icon: Ionicons.heart_outline,
              lable: S.of(context).favorite_meals,
            ),
            DrawerListTileWidget(
              onPressed: () {
                if (uid != '') {
                  navigateTo(context, const MyDayScreen());
                } else {
                  showWaringLoginDialog(context);
                }
              },
              icon: Ionicons.calendar_outline,
              lable: S.of(context).my_day,
            ),
            DrawerListTileWidget(
              onPressed: () {
                if (uid != '') {
                  navigateTo(context, const WaterReminderScreen());
                } else {
                  showWaringLoginDialog(context);
                }
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
                if (uid != '') {
                  logOutDialog(context).show();
                } else {
                  navigateToAndFinish(context, const LoginScreen());
                }
              },
              icon: uid != ''
                  ? Ionicons.log_out_outline
                  : Ionicons.log_in_outline,
              lable: uid != '' ? S.of(context).log_out : S.of(context).login,
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
