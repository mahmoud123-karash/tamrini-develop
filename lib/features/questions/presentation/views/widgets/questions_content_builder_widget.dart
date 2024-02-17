import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_states.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/message_question_builder_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/questions_content_widget.dart';

import 'loading_question_widget.dart';

class QuestionsContentBuilderWidget extends StatefulWidget {
  const QuestionsContentBuilderWidget({super.key});

  @override
  State<QuestionsContentBuilderWidget> createState() =>
      _QuestionsContentBuilderWidgetState();
}

class _QuestionsContentBuilderWidgetState
    extends State<QuestionsContentBuilderWidget> {
  @override
  void initState() {
    Timer.periodic(
      const Duration(minutes: 2),
      (timer) {
        if (mounted) {
          QuestionCubit.get(context).getQuestions();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionCubit, QuestionStates>(
      listener: (context, state) {
        if (state is LoadingGetQuestionsState) {
          showLoaderDialog(context);
        }

        if (state is ErrorGetQuestionsState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is SucessGetQuestionsState) {
          return QuestionContentWidget(
            list: state.list,
            state: state,
          );
        } else if (state is ErrorGetQuestionsState) {
          return MessageQuestionBuilderWidget(message: state.message);
        } else {
          List<QuestionModel> models = QuestionCubit.get(context).questions;
          if (models.isEmpty) {
            return const LoadingQuestionWidget();
          } else {
            return QuestionContentWidget(
              list: models,
              state: state,
            );
          }
        }
      },
    );
  }
}
