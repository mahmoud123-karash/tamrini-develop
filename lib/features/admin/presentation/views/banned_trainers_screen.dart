import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/admin/presentation/views/widgets/banned_trainers_content_widget.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/generated/l10n.dart';

class BannedTrainersScreen extends StatelessWidget {
  const BannedTrainersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).banned_trainers),
      body: BlocBuilder<TrainersCubit, TrainersStates>(
        builder: (context, state) {
          if (state is SucessGetTrainersState) {
            List<TrainerModel> list = TrainersCubit.get(context)
                .trainers
                .where((element) => element.isBanned)
                .toList();
            return BannedTrainersContentWidget(list: list);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
