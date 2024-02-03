import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_states.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/add_question_custom_button_widget.dart';

class AddQuestionCustomButtonBuilderWidget extends StatelessWidget {
  const AddQuestionCustomButtonBuilderWidget({
    super.key,
    required this.controller,
    required this.lable,
    required this.onPressed,
  });
  final TextEditingController controller;
  final String lable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionCubit, QuestionStates>(
      builder: (context, state) {
        if (state is LoadingGetQuestionsState) {
          return const CircularProgressIndicator();
        } else {
          return AddQuestionCustomButtonWidget(
            controller: controller,
            lable: lable,
            onPressed: onPressed,
          );
        }
      },
    );
  }
}
