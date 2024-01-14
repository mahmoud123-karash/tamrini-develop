import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_states.dart';
import 'package:tamrini/generated/l10n.dart';
import 'animated_container_notification_widget.dart';

class NotificationcustomadioGroupedButtonWidget extends StatelessWidget {
  const NotificationcustomadioGroupedButtonWidget({
    super.key,
    required this.lable,
    required this.onPressedN,
    required this.onPressedM,
    required this.onPressedS,
  });
  final VoidCallback onPressedN, onPressedM, onPressedS;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationStates>(
      builder: (context, state) {
        if (state is SucessGetNotificationsState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                AnimatedContainerNotificaionWidget(
                  isSelected: lable == 'notification',
                  lable: S.of(context).notification,
                  onPressed: onPressedN,
                  length: state.list
                      .where((element) => element.type == 'notification')
                      .where((element) => element.isReaden == false)
                      .toList()
                      .length,
                ),
                AnimatedContainerNotificaionWidget(
                  isSelected: lable == 'message',
                  lable: S.of(context).messages,
                  onPressed: onPressedM,
                  length: state.list
                      .where((element) => element.type == 'message')
                      .where((element) => element.isReaden == false)
                      .toList()
                      .length,
                ),
                AnimatedContainerNotificaionWidget(
                  isSelected: lable == 'system',
                  lable: S.of(context).system,
                  onPressed: onPressedS,
                  length: state.list
                      .where((element) => element.type == 'system')
                      .where((element) => element.isReaden == false)
                      .toList()
                      .length,
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
