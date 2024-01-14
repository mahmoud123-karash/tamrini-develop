import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/chat/data/repo/chat_repo_impl.dart';
import 'package:tamrini/features/chat/presentation/manager/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/send_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

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
    return BlocProvider(
      create: (context) => ChatCubit(
        getIt.get<ChatRepoImpl>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            ' widget.name',
            maxLines: 1,
          ),
          actions: const [],
        ),
        body: Column(
          children: [
            // ChatListViewBuilderWidget(scrollController: scrollController),
            SendMessageWidget(
              uid: 'widget.uid',
              recieverUid: ' widget.recieverUid',
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
