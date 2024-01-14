import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/notification/presentation/views/widgets/notifications_list_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/notifocation_custom_radio_grouped_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String lable = 'notification';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).notification,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NotificationcustomadioGroupedButtonWidget(
            lable: lable,
            onPressedN: () {
              lable = "notification";
              setState(() {});
            },
            onPressedM: () {
              lable = "message";

              setState(() {});
            },
            onPressedS: () {
              lable = "system";
              setState(() {});
            },
          ),
          Expanded(
            child: NotificationsListViewBuilderWidget(lable: lable),
          ),
        ],
      ),
    );
  }
}
