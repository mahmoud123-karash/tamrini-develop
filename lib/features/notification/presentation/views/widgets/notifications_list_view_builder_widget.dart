import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_states.dart';
import 'package:tamrini/features/notification/presentation/views/widgets/notification_list_view_widget.dart';
import 'package:tamrini/features/notification/presentation/views/widgets/notifications_message_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class NotificationsListViewBuilderWidget extends StatelessWidget {
  const NotificationsListViewBuilderWidget({super.key, required this.lable});
  final String lable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationStates>(
      builder: (context, state) {
        if (state is SucessGetNotificationsState) {
          List<NotificationModel> notifications =
              state.list.where((element) => element.type == lable).toList();
          if (notifications.isEmpty) {
            return NotificationMessageBuilderWidget(
              message: S.of(context).no_results,
            );
          }
          return NotificationListViewWidget(
            notifications: state.list,
            lable: lable,
          );
        } else if (state is ErrorGetNotificationsState) {
          return NotificationMessageBuilderWidget(message: state.toString());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
