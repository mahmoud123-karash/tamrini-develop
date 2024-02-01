import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/data/models/subscriber_model/subscriber_model.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_states.dart';
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
      SubscriberCubit.get(context).getSubscribers(gymId: widget.model.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');

    return BlocBuilder<SubscriberCubit, SubscriberStates>(
      builder: (context, state) {
        if (state is SucessGetSubscribersState) {
          bool isSub = state.list.any((element) => element.userId == uid);
          if (isSub) {
            SubscriberModel model = state.list
                .where((element) => element.userId == uid)
                .toList()
                .first;
            if (model.endDate.toDate().isBefore(DateTime.now())) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: customButton(
                  onPressed: () {},
                  lable: S.of(context).renew_sub,
                ),
              );
            } else {
              return SizedBox(
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
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
