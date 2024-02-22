import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/subscribtions/presentation/manager/subscribtion_cubit/subscription_cubit.dart';
import 'package:tamrini/features/subscribtions/presentation/manager/subscribtion_cubit/substription_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'sub_content_widget.dart';

class GymSubContentWidget extends StatelessWidget {
  const GymSubContentWidget({
    super.key,
    required this.gymId,
    required this.subId,
    required this.count,
    required this.price,
    required this.profits,
  });

  final String gymId, subId;
  final int count;
  final num price, profits;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SubContentWidget(
              contentHint: S.of(context).gym_success_payment,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<SubscriptionCubit, SubscriptionStates>(
                listener: (context, state) {
                  if (state is ErrorGetUserSubState) {
                    showSnackBar(context, state.message);
                    SubscriptionCubit.get(context).getSubscriptions();
                  }
                  if (state is SucessGetUserSubState) {
                    Navigator.pop(context);
                    showSnackBar(context, S.of(context).success_sub);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingGetUserSubState) {
                    return const CircularProgressIndicator();
                  } else {
                    return customButton(
                      onPressed: () {
                        if (subId != '') {
                          SubscriptionCubit.get(context).renewSub(
                            gymId: gymId,
                            subId: subId,
                            price: price,
                            count: count,
                            profits: profits,
                          );
                        } else {
                          SubscriptionCubit.get(context).subUser(
                            gymId: gymId,
                            count: count,
                            price: price,
                            profits: profits,
                          );
                        }
                      },
                      lable: S.of(context).end_progress,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
