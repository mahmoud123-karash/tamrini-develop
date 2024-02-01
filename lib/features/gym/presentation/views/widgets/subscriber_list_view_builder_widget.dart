import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscribers_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'subscriber_message_builder_widget.dart';

class SubscriberListViewBuilderWidget extends StatelessWidget {
  const SubscriberListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriberCubit, SubscriberStates>(
      builder: (context, state) {
        if (state is SucessGetSubscribersState) {
          if (state.list.isEmpty) {
            return SubscriberMessageBuilderWidget(
              message: S.of(context).no_results,
            );
          }
          return SubscriberListViewWidget(
            list: state.list,
          );
        } else if (state is ErrorGetSubscribersState) {
          return SubscriberMessageBuilderWidget(message: state.message);
        } else {
          return loadingWidget();
        }
      },
    );
  }
}
