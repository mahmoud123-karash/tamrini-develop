import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/suggest_exercise/presentation/manager/suggest_cubit/suggest_cubit.dart';
import 'package:tamrini/features/suggest_exercise/presentation/manager/suggest_cubit/suggest_states.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/widgets/suggest_message_builder_widget.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/widgets/suggested_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SuggestedListViewBuilderWidget extends StatelessWidget {
  const SuggestedListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestCubit, SuggestStates>(
      builder: (context, state) {
        if (state is SucessGetSuggestedExercisesState) {
          if (state.list.isEmpty) {
            return SuggestMessageBuilderWidget(
              message: S.of(context).no_exercises_yet,
            );
          }
          return SuggestedListViewWidget(list: state.list);
        } else if (state is ErrorGetSuggestedExercisestate) {
          return SuggestMessageBuilderWidget(message: state.message);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
