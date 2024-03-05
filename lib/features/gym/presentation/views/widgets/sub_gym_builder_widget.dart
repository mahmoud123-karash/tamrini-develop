import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/payment/presentation/views/gym_sub_payment_screen.dart';
import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';
import 'package:tamrini/features/subscribtions/presentation/manager/subscribtion_cubit/subscription_cubit.dart';
import 'package:tamrini/features/subscribtions/presentation/manager/subscribtion_cubit/substription_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'gym_custom_buttons_widget.dart';
import 'subscriber_message_builder_widget.dart';

class SubGymBuilderWidget extends StatefulWidget {
  const SubGymBuilderWidget({super.key, required this.model});
  final GymModel model;

  @override
  State<SubGymBuilderWidget> createState() => _SubGymBuilderWidgetState();
}

class _SubGymBuilderWidgetState extends State<SubGymBuilderWidget> {
  @override
  void initState() {
    if (mounted) {
      SubscriptionCubit.get(context).getSubscriptions();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return BlocBuilder<SubscriptionCubit, SubscriptionStates>(
      builder: (context, state) {
        if (state is SucessGetUserSubState) {
          bool isSub =
              state.list.any((element) => element.gymId == widget.model.id);
          if (isSub) {
            SubscriptionModel model = state.list
                .where((element) => element.gymId == widget.model.id)
                .toList()
                .first;
            if (model.endDate.toDate().isBefore(DateTime.now())) {
              return userType == UserType.gymOwner
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customButton(
                        onPressed: () {
                          navigateTo(
                            context,
                            GymSubPaymentScreen(
                              gymId: widget.model.id,
                              subId: model.uid,
                              price: widget.model.price,
                              count: widget.model.subcribersCount,
                              profits:
                                  widget.model.profits + widget.model.price,
                            ),
                          );
                        },
                        lable: S.of(context).renew_sub,
                      ),
                    );
            } else {
              return userType == UserType.gymOwner
                  ? Container()
                  : SizedBox(
                      height: 50,
                      child: SubscriberMessageBuilderWidget(
                        message: S.of(context).sub_hint,
                        isSub: true,
                      ),
                    );
            }
          } else {
            return GymCustomButtonsWidget(
              lat: widget.model.location.latitude,
              long: widget.model.location.longitude,
              gymId: widget.model.id,
              count: widget.model.subcribersCount + 1,
              price: widget.model.price,
              profits: widget.model.profits + widget.model.price,
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
