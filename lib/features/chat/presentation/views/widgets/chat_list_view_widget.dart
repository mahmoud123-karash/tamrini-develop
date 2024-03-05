import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/chat/data/models/message_model.dart';
import 'package:tamrini/features/chat/presentation/views/widgets/message_item_widget.dart';

class ChatListViewWidget extends StatelessWidget {
  const ChatListViewWidget(
      {super.key, required this.messages, required this.scrollController});
  final List<MessageModel> messages;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          reverse: true,
          controller: scrollController,
          itemBuilder: (context, index) => MessageItemWidget(
            isSender: CacheHelper.getData(key: 'uid') ??
                "" == messages[index].senderUid,
            message: messages[index].message,
            time: messages[index].time.toDate(),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          itemCount: messages.length,
        ),
      ),
    );
  }
}
