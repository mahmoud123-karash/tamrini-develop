import 'package:flutter/material.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';

import 'notification_item_widget.dart';

class NotificationListViewWidget extends StatefulWidget {
  const NotificationListViewWidget({super.key, required this.notifications});
  final List<NotificationModel> notifications;

  @override
  State<NotificationListViewWidget> createState() =>
      _NotificationListViewWidgetState();
}

class _NotificationListViewWidgetState
    extends State<NotificationListViewWidget> {
  ScrollController scrollController = ScrollController();
  int length = 10;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.notifications.length > length) {
        length += 10;
        Future.delayed(const Duration(seconds: 1)).then((value) {
          if (mounted) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setState(() {}));
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (length > index) {
            return NotificationItemWidget(
              model: widget.notifications[index],
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 30,
        ),
        itemCount: length > widget.notifications.length
            ? widget.notifications.length
            : length + 1,
      ),
    );
  }
}
