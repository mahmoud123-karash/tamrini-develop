import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

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
            title,
            style: TextStyles.style13.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: width - (30 + 70 + 20 + 20)),
          child: Text(
            body,
            style:
                TextStyles.style12.copyWith(color: greyColor.withOpacity(0.9)),
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
