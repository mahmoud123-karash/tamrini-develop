import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AnswerCubit extends Cubit<QuestionStates> {
  AnswerCubit(this.questionRepo) : super(InitialQuestionState());

  static AnswerCubit get(context) => BlocProvider.of(context);

  final QuestionRepo questionRepo;

  void addNewQuestion(
      {required String body, required BuildContext context}) async {
    emit(LoadingAddQuestionState());
    var result = await questionRepo.addNewQuestion(body: body);
    result.fold(
      (message) {
        log(message);
        emit(ErrorAddQuestionState(message));
      },
      (success) {
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add);
        emit(SucessAddQuestionState());
      },
    );
  }

  void updateQuestion({
    required QuestionModel model,
    required BuildContext context,
    required String id,
    required String message,
  }) async {
    emit(LoadingUpdateQuestionState());

    var result = await questionRepo.updateQuestion(id: id, model: model);
    result.fold(
      (message) {
        log(message);
        emit(ErrorUpdateQuestionState(message));
      },
      (success) {
        if (message != '') {
          showSnackBar(context, message);
          Navigator.pop(context);
        }
        emit(SucessUpdateQuestionState());
      },
    );
  }

  void removeQuestion({
    required BuildContext context,
    required String id,
  }) async {
    emit(LoadingRemoveQuestionState());

    var result = await questionRepo.removeQuestion(id: id);
    result.fold(
      (message) {
        log(message);
        emit(ErrorRemoveQuestionState(message));
      },
      (success) {
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessRemoveQuestionState());
      },
    );
  }
}
