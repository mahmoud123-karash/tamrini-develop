import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/trainee_supplemement_content_widght.dart';

class TraineeSupplementsScreen extends StatelessWidget {
  const TraineeSupplementsScreen(
      {super.key,
      required this.traineeId,
      this.supplements,
      required this.logo});
  final String traineeId;
  final List<String>? supplements;
  final String logo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).nuttritions),
      body: BlocBuilder<TraineeCubit, TraineeStates>(
        builder: (context, state) {
          TraineeModel? model = supplements != null
              ? null
              : TraineeCubit.get(context).getTrainee(id: traineeId);
          return TraineeSupplementContentWidget(
            supplements: supplements,
            model: model,
            logo: logo,
          );
        },
      ),
    );
  }
}
