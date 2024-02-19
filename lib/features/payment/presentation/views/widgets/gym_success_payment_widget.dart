import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/subscribtions/presentation/manager/subscribtion_cubit/subscription_cubit.dart';
import 'package:tamrini/features/subscribtions/presentation/manager/subscribtion_cubit/substription_states.dart';
import 'package:tamrini/generated/l10n.dart';

class GymPaymentSuccessWidget extends StatelessWidget {
  const GymPaymentSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            child: Center(
              child: Icon(
                Icons.done,
                color: appColor,
                size: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).gym_success_payment,
            style: TextStyles.style14.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          BlocConsumer<SubscriptionCubit, SubscriptionStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingGetUserSubState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return customButton(
                  onPressed: () {},
                  lable: S.of(context).end_progress,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
