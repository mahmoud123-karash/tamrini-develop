// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/messaging.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/awesome_notification.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';
import 'package:tamrini/features/navBar/presentation/manager/navbar_cubit/navbar_cubit.dart';
import 'package:tamrini/features/navBar/presentation/manager/navbar_cubit/navbar_states.dart';
import 'package:tamrini/features/navBar/presentation/manager/update_cubit/update_cubit.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/badge_notification_icon_widget.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'widgets/curved_nav_bar_widget.dart';
import 'widgets/drawer_widget.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  void initState() {
    UpdateCubit.get(context).update();
    NotificationCubit.get(context).getData();
    DayCubit.get(context).getData();
    log(CacheHelper.getData(key: 'deviceToken') ?? '');
    initiGetprofile(context);
    getintil(context);
    onMessageOpenedApp(context: context);
    onMessage(context: context);
    listenNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarStates>(
        builder: (context, state) {
          NavBarCubit cubit = NavBarCubit.get(context);
          return WillPopScope(
            onWillPop: () async {
              if (cubit.currentIndex != 2) {
                cubit.changeIndex(2);
                return false;
              }
              return true;
            },
            child: Scaffold(
              drawer: const MyDrawer(),
              appBar: myAppBar(
                cubit.titles(context)[cubit.currentIndex],
                actions: [
                  const BadgeNotificationIconWidget(),
                ],
              ),
              bottomNavigationBar: CurvedNavBarWidget(cubit: cubit),
              body: cubit.screens[cubit.currentIndex],
            ),
          );
        },
      ),
    );
  }
}
