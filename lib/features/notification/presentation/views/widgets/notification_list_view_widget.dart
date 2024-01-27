import 'package:flutter/material.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/notification/presentation/views/widgets/notification_item_builder_widget.dart';

class NotificationListViewWidget extends StatefulWidget {
  const NotificationListViewWidget(
      {super.key, required this.notifications, required this.lable});
  final List<NotificationModel> notifications;
  final String lable;

  @override
  State<NotificationListViewWidget> createState() =>
      _NotificationListViewWidgetState();
}

class _NotificationListViewWidgetState
    extends State<NotificationListViewWidget> {
  ScrollController scrollController = ScrollController();
  int length = 10;

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (mounted) {
        if (widget.notifications
            .where((element) => element.isReaden == false)
            .toList()
            .isNotEmpty) {
          NotificationCubit.get(context).updateNotification(
            list: widget.notifications,
            lable: widget.lable,
          );
        }
      }
    });
    super.didChangeDependencies();
  }

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
      if (widget.notifications
              .where((element) => element.type == widget.lable)
              .toList()
              .length >
          length) {
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
        itemBuilder: (context, index) {
          if (length > index) {
            return NotificationItemBuilderWidget(
              model: widget.notifications
                  .where((element) => element.type == widget.lable)
                  .toList()[index],
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
        itemCount: length >
                widget.notifications
                    .where((element) => element.type == widget.lable)
                    .toList()
                    .length
            ? widget.notifications
                .where((element) => element.type == widget.lable)
                .toList()
                .length
            : length + 1,
      ),
    );
  }
}
