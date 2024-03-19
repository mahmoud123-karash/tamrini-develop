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
    String result;
    switch (title) {
      case 'answer':
        result = S.of(context).new_comment_question;
        break;
      case 'ban_gym':
        result = S.of(context).banned_gym_hint;
        break;
      case 'no_ban_gym':
        result = S.of(context).no_banned_gym_hint;
        break;
      case 'ban_store':
        result = S.of(context).ban_titile_store;
        break;
      case 'no_ban_store':
        result = S.of(context).no_ban_titile_store;
        break;
      case 'order':
        result = S.of(context).order_delivered;
        break;
      case 'new_order':
        result = S.of(context).new_order;
        break;
      case 'promotion':
        result = S.of(context).new_promtion_request;
        break;
      case 'promotion_accept':
        result = S.of(context).accept_request_promotion;
        break;
      case 'ban_trainer':
        result = S.of(context).ban_title_trainer;
        break;
      case 'no_ban_trainer':
        result = S.of(context).no_ban_title_trainer;
        break;
      case 'new_trainee':
        result = S.of(context).new_trainee_joined;
        break;
      case 'follow':
        result = S.of(context).follow_title;
        break;
      case 'course':
        result = S.of(context).course_title;
        break;
      case 'renew_trainee':
        result = S.of(context).renew_trainee_title;
        break;
      case 'message':
        result = S.of(context).new_message;
        break;
      case 'request_profits':
        result = S.of(context).request_profits_title;
        break;
      case 'accept_profits':
        result = S.of(context).accept_profits;
        break;
      default:
        result = title;
        break;
    }
    return result;
  }
}
