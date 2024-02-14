import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/chat/presentation/views/chat_screen.dart';

class ChatIconBadgeWidget extends StatelessWidget {
  const ChatIconBadgeWidget({
    super.key,
    required this.name,
    required this.image,
    required this.chatId,
    required this.recieverUid,
  });
  final String name, image, chatId, recieverUid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          ChatScreen(
            name: name,
            image: image,
            chatId: chatId,
            recieverUid: recieverUid,
          ),
        );
      },
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
