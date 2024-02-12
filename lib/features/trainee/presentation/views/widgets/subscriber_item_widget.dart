import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/writer_row_widget.dart';
import 'package:tamrini/features/chat/presentation/views/chat_screen.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';

import '../trainee_screen.dart';
import 'chat_icon_widget.dart';

class SubscriberItemWidget extends StatelessWidget {
  const SubscriberItemWidget({super.key, required this.model});

  final TraineeModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          navigateTo(context, TraineeScreen(user: model.user!, model: model));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appColor.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: WriterRowWidget(
                    model: model.user!,
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const ChatScreen());
                  },
                  child: const ChatIconWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
