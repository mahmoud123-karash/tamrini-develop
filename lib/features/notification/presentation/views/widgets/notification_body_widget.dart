import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

import 'user_name_and_time_ago_notification_widget.dart';

class NotificationBodyWidget extends StatelessWidget {
  const NotificationBodyWidget({
    super.key,
    required this.title,
    required this.body,
    required this.date,
    required this.userName,
  });
  final String title, body;
  final DateTime date;
  final String userName;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserNameAndTimeAgoNotificationWidget(date: date, userName: userName),
        Container(
          constraints: BoxConstraints(maxWidth: width - (30 + 70 + 20 + 20)),
          child: Text(
            getNotificationTitle(context),
            style: TextStyles.style13.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: width - (30 + 70 + 20 + 20)),
          child: Text(
            body,
            style: TextStyles.style12.copyWith(
              color: greyColor.withOpacity(0.9),
            ),
            maxLines: 1,
          ),
        )
      ],
    );
  }

  String getNotificationTitle(BuildContext context) {
    return title == 'answer'
        ? S.of(context).new_comment_question
        : title == 'ban_question'
            ? S.of(context).ban_your_question
            : title == 'ban_gym'
                ? S.of(context).banned_gym_hint
                : title == 'no_ban_gym'
                    ? S.of(context).no_banned_gym_hint
                    : title == 'ban_store'
                        ? S.of(context).ban_titile_store
                        : title == 'no_ban_store'
                            ? S.of(context).no_ban_titile_store
                            : title;
  }
}
