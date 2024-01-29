import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tamrini/core/contants/constants.dart';

class BadgeOrderIconWidget extends StatelessWidget {
  const BadgeOrderIconWidget({super.key, required this.length});
  final int length;

  @override
  Widget build(BuildContext context) {
    return length == 0
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: badges.Badge(
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red,
              ),
              badgeContent: Text(
                '$length',
                style: TextStyle(
                  color: whiteColor,
                ),
              ),
            ),
          );
  }
}
