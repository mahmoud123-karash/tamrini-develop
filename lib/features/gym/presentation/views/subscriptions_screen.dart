import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriber_message_builder_widget.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriptions_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getSubscriptions(),
      child: Scaffold(
        appBar: myAppBar(S.of(context).Subscriptions),
        body: BlocBuilder<UserCubit, UserStates>(
          builder: (context, state) {
            if (state is SucessGetUserSubState) {
              if (state.list.isEmpty) {
                return SubscriberMessageBuilderWidget(
                  message: S.of(context).no_sub,
                );
              } else {
                return SubscriptionsListViewWidget(list: state.list);
              }
            } else if (state is ErrorGetUserSubState) {
              return SubscriberMessageBuilderWidget(
                message: state.message,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
