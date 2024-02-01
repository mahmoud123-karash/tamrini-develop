import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/models/subscription_model/subscription_model.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriptions_item_widget.dart';

class SubscriptionItemBuilderWidget extends StatelessWidget {
  const SubscriptionItemBuilderWidget({super.key, required this.model});
  final SubscriptionModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymCubit, GymStates>(
      builder: (context, state) {
        List<GymModel> list = GymCubit.get(context).getGym(model.gymId);
        GymModel? gym = list.isEmpty ? null : list.first;

        return gym == null
            ? Container()
            : SubscribtionsItemWidget(model: model, gym: gym);
      },
    );
  }
}
