import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/auth/domain/use_cases/apple_sign_in_use_case.dart';

import '../../../../../core/services/show_dialog.dart';
import 'apple_states.dart';

class AppleCubit extends Cubit<AppleStates> {
  AppleCubit(this.appleSignInUseCase) : super(InitialAppleSignInState());
  static AppleCubit get(context) => BlocProvider.of(context);

  final AppleSignInUseCase appleSignInUseCase;
  void loginWithApple(context) async {
    showLoaderDialog(context);
    emit(LoadingAppleSignInState());
    var result = await appleSignInUseCase.appleSignIn();
    result.fold((message) {
      emit(ErrorAppleSignInState(message));
      Navigator.pop(context);
    }, (user) {
      Navigator.pop(context);
      emit(SuccessAppleSignInState(user));
    });
  }
}
