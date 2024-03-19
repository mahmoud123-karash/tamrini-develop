import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/trainer_subscriber_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TraineeContentBuilderWidget extends StatelessWidget {
  const TraineeContentBuilderWidget({super.key, required this.logo});
  final String logo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TraineeCubit, TraineeStates>(
      builder: (context, state) {
        if (state is SucessGetTraineesState) {
          if (state.list.isEmpty) {
            return Center(
              child: Text(
                S.of(context).no_results,
              ),
            );
          } else {
            return TrainerSubscriberContentWidget(
              list: state.list,
              logo: logo,
            );
          }
        } else if (state is ErrorGetTraineesState) {
          return Center(
            child: Text(
              state.message,
            ),
          );
        } else {
          return loadingWidget();
        }
      },
    );
  }
}
