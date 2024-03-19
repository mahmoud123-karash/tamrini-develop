import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/writer_row_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';

import '../trainee_screen.dart';
import 'chat_icon_widget.dart';

class SubscriberItemWidget extends StatelessWidget {
  const SubscriberItemWidget(
      {super.key, required this.model, required this.image});

  final TraineeModel model;
  final String image;

  @override
  Widget build(BuildContext context) {
    bool isEnd = model.dateOfSubscription
        .toDate()
        .add(const Duration(days: 30))
        .isAfter(DateTime.now());
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          navigateTo(
              context,
              TraineeScreen(
                user: model.user!,
                model: model,
                logo: image,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: !isEnd
                ? Colors.red.withOpacity(0.3)
                : appColor.withOpacity(0.2),
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
                if (isEnd)
                  ChatIconBadgeWidget(
                    name: model.user!.name,
                    image: model.user!.image,
                    chatId: model.chatId,
                    recieverUid: model.uid,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
