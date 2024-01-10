import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_states.dart';

class QuestionCubit extends Cubit<QuestionStates> {
  QuestionCubit(this.questionRepo) : super(InitialQuestionState());

  static QuestionCubit get(context) => BlocProvider.of(context);

  final QuestionRepo questionRepo;

  void getUser({required String body}) async {
    emit(LoadingAddQuestionState());
    var result = await questionRepo.addNewQuestion(body: body);
    result.fold(
      (message) {
        log(message);
        emit(ErrorAddQuestionState(message));
      },
      (added) {
        emit(SucessAddQuestionState());
      },
    );
  }
}
