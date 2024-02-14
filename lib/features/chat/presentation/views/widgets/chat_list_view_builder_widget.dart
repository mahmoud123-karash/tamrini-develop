import 'package:tamrini/features/chat/data/models/message_model.dart';
import 'package:tamrini/features/chat/presentation/views/widgets/chat_list_view_widget.dart';
import 'package:flutter/material.dart';

class ChatListViewBuilderWidget extends StatelessWidget {
  const ChatListViewBuilderWidget(
      {super.key, required this.scrollController, required this.messages});
  final ScrollController scrollController;
  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ChatListViewWidget(
      messages: messages,
      scrollController: scrollController,
    );
  }
}
