import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
import 'package:tamrini/features/gym/data/models/subscriber_model/subscriber_model.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriber_item_loading_builder_widget.dart';

import 'subcribers_item_widget.dart';

class SubscriberItemBuilderWidget extends StatelessWidget {
  const SubscriberItemBuilderWidget({super.key, required this.model});
  final SubscriberModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUser(uid: model.userId),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserState) {
            return SubscribersItemWidget(
              model: model,
              user: state.model,
            );
          } else if (state is ErrorGetUserState) {
            return Container();
          } else {
            return const SubscriberItemLoadingBuilderWidget();
          }
        },
      ),
    );
  }
}
