import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/suggest_exercise/presentation/manager/suggest_cubit/suggest_cubit.dart';
import 'package:tamrini/features/suggest_exercise/presentation/manager/suggest_cubit/suggest_states.dart';
import 'package:tamrini/generated/l10n.dart';

class SuggestExerciseCustomButtonBuilderWidget extends StatelessWidget {
  const SuggestExerciseCustomButtonBuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuggestCubit, SuggestStates>(
      listener: (context, state) {
        if (state is ErrorSuggestState) {
          showSnackBar(context, state.message);
        }
        if (state is SucessSuggestState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: S.of(context).success_suggest_exercise,
            desc: S.of(context).review_suggest_exercise,
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnOkOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        }
      },
      builder: (context, state) {
        if (state is LoadingSuggestState) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: customButton(
              onPressed: onPressed,
              lable: lable,
            ),
          );
        }
      },
    );
  }
}
