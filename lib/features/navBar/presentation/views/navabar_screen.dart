// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/navBar/presentation/manager/navbar_cubit/navbar_cubit.dart';
import 'package:tamrini/features/navBar/presentation/manager/navbar_cubit/navbar_states.dart';
import 'package:tamrini/features/navBar/presentation/manager/update_cubit/update_cubit.dart';
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
