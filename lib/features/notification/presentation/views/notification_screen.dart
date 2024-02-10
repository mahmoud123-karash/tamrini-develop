import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/notification/presentation/views/widgets/notifications_list_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).notification,
      ),
      body: const NotificationsListViewBuilderWidget(),
    );
  }
}
