import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/chat/presentation/views/chat_screen.dart';

class ChatIconBadgeWidget extends StatelessWidget {
  const ChatIconBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, const ChatScreen());
      },
      child: badges.Badge(
        badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.red,
        ),
        badgeContent: Text(
          '5',
          style: TextStyle(
            color: whiteColor,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: appColor,
          child: Center(
            child: Icon(
              Icons.chat_outlined,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
