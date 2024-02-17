import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/navBar/presentation/manager/navbar_cubit/navbar_cubit.dart';

class CurvedNavBarWidget extends StatelessWidget {
  const CurvedNavBarWidget({super.key, required this.cubit});
  final NavBarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: cubit.currentIndex,
      color: appColor,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: appColor,
      height: 60,
      items: const <Widget>[
        Icon(
          Icons.restaurant,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.fitness_center,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.shopping_cart,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.article,
          size: 30,
          color: Colors.white,
        ),
      ],
      onTap: (index) {
        cubit.changeIndex(index);
      },
    );
  }
}
