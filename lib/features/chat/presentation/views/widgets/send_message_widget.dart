import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/chat/presentation/manager/chat_cubit.dart';
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
    return Align(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          children: [
            SendTextFieldWidget(controller: controller),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  ChatCubit.get(context).sendMessage(
                    uid: widget.uid,
                    messageText: controller.text,
                    recieverUid: widget.recieverUid,
                  );
                  if (widget.scrollController.hasClients) {
                    widget.scrollController.jumpTo(
                      widget.scrollController.position.minScrollExtent,
                    );
                  }
                  controller.clear();
                }
              },
              icon: Icon(
                Icons.send,
                color: appColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
