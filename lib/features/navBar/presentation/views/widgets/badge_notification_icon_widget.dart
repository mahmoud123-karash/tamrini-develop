import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/notification/presentation/views/notification_screen.dart';

class BadgeNotificationIconWidget extends StatelessWidget {
  const BadgeNotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        navigateTo(context, const NotificationScreen());
      },
      icon: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: badges.Badge(
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.red,
          ),
          badgeContent: Text(
            '3',
            style: TextStyle(
              color: whiteColor,
            ),
          ),
          child: const Icon(Ionicons.notifications_outline),
        ),
      ),
    );
  }
}
