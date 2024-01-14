import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_states.dart';
import 'package:tamrini/features/notification/presentation/views/notification_screen.dart';

class BadgeNotificationIconWidget extends StatelessWidget {
  const BadgeNotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationStates>(
      builder: (context, state) {
        if (state is SucessGetNotificationsState) {
          int length = state.list
              .where((element) => element.isReaden == false)
              .toList()
              .length;
          return IconButton(
            onPressed: () {
              navigateTo(context, const NotificationScreen());
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: length == 0
                  ? const Icon(Ionicons.notifications_outline)
                  : badges.Badge(
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Colors.red,
                      ),
                      badgeContent: Text(
                        '$length',
                        style: TextStyle(
                          color: whiteColor,
                        ),
                      ),
                      child: const Icon(Ionicons.notifications_outline),
                    ),
            ),
          );
        } else {
          return IconButton(
            onPressed: () {
              navigateTo(context, const NotificationScreen());
            },
            icon: const Icon(Ionicons.notifications_outline),
          );
        }
      },
    );
  }
}
