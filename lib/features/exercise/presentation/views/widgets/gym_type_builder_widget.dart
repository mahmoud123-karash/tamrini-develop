import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_type_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/loading_type_widget.dart';
import 'package:tamrini/features/gym/presentation/views/all_gyms_screen.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/generated/l10n.dart';

class GymTypeBuilderWidget extends StatelessWidget {
  const GymTypeBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymCubit, GymStates>(
      builder: (context, state) {
        if (state is SucessGetGymsState) {
          if (state.list.isEmpty) {
            return Container();
          }
          return ExerciseTypeWidget(
            image: Assets.imagesExercise,
            lable: S.of(context).slatGym,
            onPressed: () {
              navigateTo(context, AllGymsScreen(models: state.list));
            },
          );
        } else {
          return const LoadingTypeWidget();
        }
      },
    );
  }
}
