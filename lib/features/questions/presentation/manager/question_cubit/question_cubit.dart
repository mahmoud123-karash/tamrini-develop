import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_states.dart';
import 'package:tamrini/generated/l10n.dart';

class QuestionCubit extends Cubit<QuestionStates> {
  QuestionCubit(this.questionRepo) : super(InitialQuestionState());

  static QuestionCubit get(context) => BlocProvider.of(context);

  final QuestionRepo questionRepo;

  List<QuestionModel> questions = [];
  void getQuestions({String? message}) async {
    var result = await questionRepo.getQuestons();
    result.fold((message) {
      emit(ErrorGetQuestionsState(message));
    }, (list) {
      List<QuestionModel> models = clearBannedQuestions(list);
      questions = models;
      if (message != null) {
        showToast(message, gravity: ToastGravity.BOTTOM);
      }
      emit(SucessGetQuestionsState(models));
    });
  }

  List<QuestionModel> clearBannedQuestions(List<QuestionModel> list) {
    List<QuestionModel> models = [];
    for (var element in list) {
      if (element.isBanned == false) {
        models.add(element);
      }
    }
    return models;
  }

  void addNewQuestion({
    required String body,
    required BuildContext context,
  }) async {
    emit(LoadingGetQuestionsState());
    var result = await questionRepo.addNewQuestion(body: body);
    result.fold(
      (message) {
        log(message);
        getQuestions();
        emit(ErrorGetQuestionsState(message));
      },
      (list) {
        Navigator.pop(context);
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add);
        List<QuestionModel> models = clearBannedQuestions(list);
        questions = models;
        emit(SucessGetQuestionsState(models));
      },
    );
  }

  void updateQuestion({
    required QuestionModel model,
    required BuildContext context,
    required String id,
    required String message,
  }) async {
    emit(LoadingGetQuestionsState());
    var result = await questionRepo.updateQuestion(id: id, model: model);
    result.fold(
      (message) {
        log(message);
        getQuestions();
        emit(ErrorGetQuestionsState(message));
      },
      (list) {
        if (message != '') {
          showSnackBar(context, message);
        }
        Navigator.pop(context);
        Navigator.pop(context);
        List<QuestionModel> models = clearBannedQuestions(list);
        questions = models;
        emit(SucessGetQuestionsState(models));
      },
    );
  }

  void removeQuestion({
    required BuildContext context,
    required String id,
  }) async {
    emit(LoadingGetQuestionsState());
    var result = await questionRepo.removeQuestion(id: id);
    result.fold(
      (message) {
        log(message);
        getQuestions();
        emit(ErrorGetQuestionsState(message));
      },
      (list) {
        Navigator.pop(context);
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_remove);
        List<QuestionModel> models = clearBannedQuestions(list);
        questions = models;
        emit(SucessGetQuestionsState(models));
      },
    );
  }
}
