import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/chat/data/repo/chat_repo_impl.dart';
import 'package:tamrini/features/chat/presentation/manager/chat_cubit.dart';
import 'package:tamrini/features/chat/presentation/manager/chat_states.dart';
import 'package:tamrini/features/chat/presentation/views/widgets/send_text_filed_widget.dart';
import 'package:flutter/material.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({
    super.key,
    required this.uid,
    required this.recieverUid,
    required this.scrollController,
  });
  final String uid, recieverUid;
  final ScrollController scrollController;

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        getIt.get<ChatRepoImpl>(),
      ),
      child: BlocBuilder<ChatCubit, ChatStates>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              SendTextFieldWidget(
                controller: controller,
                onChange: () {
                  setState(() {});
                },
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                onPressed: controller.text != ''
                    ? () async {
                        if (widget.scrollController.hasClients) {
                          widget.scrollController.jumpTo(
                            widget.scrollController.position.minScrollExtent,
                          );
                        }
                        if (controller.text != '') {
                          ChatCubit.get(context).sendMessage(
                            uid: widget.uid,
                            messageText: controller.text,
                            recieverUid: widget.recieverUid,
                            imagepath: '',
                          );
                        }
                        controller.clear();
                      }
                    : null,
                icon: Icon(
                  Icons.send,
                  color: controller.text != '' ? appColor : greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
