import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class UserNameAndTimeAgoNotificationWidget extends StatelessWidget {
  const UserNameAndTimeAgoNotificationWidget(
      {super.key, required this.date, required this.userName});
  final DateTime date;
  final String userName;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      constraints: BoxConstraints(maxWidth: width - (30 + 70 + 20 + 20)),
      child: Row(
        children: [
          Container(
            constraints:
                BoxConstraints(maxWidth: (width - (30 + 70 + 20 + 20)) / 2),
            child: Text(
              userName,
              style: TextStyles.style13.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ),
          const Spacer(),
          Text(
            Intl.getCurrentLocale() == 'ar'
                ? formatTimeDifferenceInArabic(date)
                : formatTimeDifference(date),
            style: TextStyles.style12.copyWith(),
          ),
        ],
      ),
    );
  }
}
