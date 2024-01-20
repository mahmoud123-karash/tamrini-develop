import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';
import 'package:tamrini/features/questions/domain/use_cases/write_answer_use_case.dart';
import 'package:tamrini/features/questions/presentation/manager/answer_cubit/answer_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AnswerCubit extends Cubit<AnswerStates> {
  AnswerCubit(this.questionRepo, this.writeAnswerUseCase)
      : super(InitialAnswerState());

  static AnswerCubit get(context) => BlocProvider.of(context);

  final QuestionRepo questionRepo;
  final WriteAnswerUseCase writeAnswerUseCase;

  void addNewAnswer({
    required String answer,
    required QuestionModel model,
    required String id,
    required String token,
  }) async {
    emit(LoadingAddAnswerState());
    var result = await writeAnswerUseCase.answer(
        answer: answer, model: model, id: id, token: token);

    result.fold(
      (message) {
        log(message);
        emit(ErrorAddAnswerState(message));
      },
      (success) {
        emit(SucessAddAnswerState());
      },
    );
  }

  void updateAnswer({
    required AnswerModel aModel,
    required QuestionModel model,
    required BuildContext context,
    required String id,
    required String newAnswer,
  }) async {
    emit(LoadingUpdateAnswerState());
    AnswerModel answer = AnswerModel(
      date: aModel.date,
      answer: newAnswer,
      userUid: aModel.userUid,
    );
    List<AnswerModel> list = model.answers;
    list.remove(aModel);
    list.add(answer);
    QuestionModel question = QuestionModel(
      date: model.date,
      body: model.body,
      askerUid: model.askerUid,
      answersCount: model.answersCount,
      answers: list,
      isBanned: model.isBanned,
    );
    var result = await questionRepo.updateQuestion(id: id, model: question);
    result.fold(
      (message) {
        log(message);
        emit(ErrorUpdateAnswerState(message));
      },
      (success) {
        showSnackBar(context, S.of(context).success_update_answer);
        Navigator.pop(context);
        emit(SucessUpdateAnswerState());
      },
    );
  }

  void removeAnswer({
    required AnswerModel aModel,
    required QuestionModel model,
    required BuildContext context,
    required String id,
  }) async {
    emit(LoadingUpdateAnswerState());
    List<AnswerModel> list = model.answers;
    list.remove(aModel);
    QuestionModel question = QuestionModel(
      date: model.date,
      body: model.body,
      askerUid: model.askerUid,
      answersCount: model.answersCount - 1,
      answers: list,
      isBanned: model.isBanned,
    );
    var result = await questionRepo.updateQuestion(id: id, model: question);
    result.fold(
      (message) {
        log(message);
        emit(ErrorUpdateAnswerState(message));
      },
      (success) {
        showSnackBar(context, S.of(context).success_remove_answer);
        Navigator.pop(context);
        emit(SucessUpdateAnswerState());
      },
    );
  }
}