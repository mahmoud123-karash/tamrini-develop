import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/chat/data/models/message_model.dart';
import 'package:tamrini/features/chat/presentation/manager/chat_cubit.dart';
import 'package:tamrini/features/chat/presentation/manager/chat_states.dart';
import 'package:tamrini/features/chat/presentation/views/widgets/chat_list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListViewBuilderWidget extends StatelessWidget {
  const ChatListViewBuilderWidget({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {
        if (state is ErrorSendMessageState) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        List<MessageModel> messages = ChatCubit.get(context).messages;
        List<MessageModel> reversedMessage = messages.reversed.toList();

        if (messages.isEmpty) {
          return const Expanded(
            child: Center(
              child: Text('No Messages yet'),
            ),
          );
        }
        return ChatListViewWidget(
          messages: reversedMessage,
          scrollController: scrollController,
        );
      },
    );
  }
}
