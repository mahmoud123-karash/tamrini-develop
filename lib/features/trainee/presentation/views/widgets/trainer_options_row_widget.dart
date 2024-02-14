import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/chat_icon_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';

import 'trainer_icon_options_widget.dart';

class TrainerOptionsRowWidget extends StatelessWidget {
  const TrainerOptionsRowWidget({
    super.key,
    required this.trainerId,
    required this.isEnd,
    required this.name,
    required this.image,
    required this.chatId,
    required this.recieverUid,
  });
  final String trainerId, name, image, chatId, recieverUid;
  final bool isEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TrainerIconOptionsWidget(
          onTap: () {
            navigateTo(context, TrainerProfileScreen(id: trainerId));
          },
          icon: Icons.person_outlined,
        ),
        if (!isEnd)
          ChatIconBadgeWidget(
            name: name,
            image: image,
            chatId: chatId,
            recieverUid: recieverUid,
          ),
      ],
    );
  }
}
