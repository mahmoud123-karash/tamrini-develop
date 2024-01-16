import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit(this.questionRepo) : super(InitialUserState());

  static UserCubit get(context) => BlocProvider.of(context);

  final QuestionRepo questionRepo;

  void getUser({required String uid}) async {
    emit(LoadingGetUserState());
    var result = await questionRepo.getUser(uid: uid);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetUserState(message));
      },
      (model) {
        if (!isClosed) {
          emit(SucessGetUserState(model));
        }
      },
    );
  }
}
