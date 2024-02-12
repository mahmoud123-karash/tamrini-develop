import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tamrini/core/contants/constants.dart';

class ChatIconWidget extends StatelessWidget {
  const ChatIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
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
    );
  }
}
