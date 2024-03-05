import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/chat/data/models/message_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/chat_list_view_widget.dart';
import 'widgets/send_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.chatId,
      required this.recieverUid});
  final String name, image, chatId, recieverUid;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.name,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: CircleAvatar(
              backgroundImage: widget.image != ''
                  ? FirebaseImageProvider(
                      FirebaseUrl(widget.image),
                    )
                  : const AssetImage(Assets.imagesProfile) as ImageProvider,
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc(widget.chatId)
            .collection('data')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<MessageModel> messages = [];
          if (snapshot.data != null) {
            for (var element in snapshot.data!.docs) {
              MessageModel model = MessageModel.fromJson(element.data());
              messages.add(model);
            }
          }

          return Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context).no_messages_yet,
                        ),
                      )
                    : ChatListViewWidget(
                        scrollController: scrollController,
                        messages: messages,
                      ),
              ),
              SendMessageWidget(
                uid: widget.chatId,
                recieverUid: widget.recieverUid,
                scrollController: scrollController,
              ),
            ],
          );
        },
      ),
    );
  }
}
