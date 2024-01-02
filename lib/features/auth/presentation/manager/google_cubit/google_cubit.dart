import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:tamrini/features/auth/presentation/manager/google_cubit/google_states.dart';

import '../../../../../core/services/loader_dialog.dart';

class GoogleCubit extends Cubit<GoogleStates> {
  GoogleCubit(this.googleSignInUseCase) : super(InitialGoogleSignInState());
  static GoogleCubit get(context) => BlocProvider.of(context);

  final GoogleSignInUseCase googleSignInUseCase;

  void loginWithGoogle(context) async {
    showLoaderDialog(context);
    emit(LoadingGoogleSignInState());
    var result = await googleSignInUseCase.googleSignIn();
    result.fold((message) {
      emit(ErrorGoogleSignInState(message));
      Navigator.pop(context);
    }, (user) {
      Navigator.pop(context);
      emit(SuccessGoogleSignInState(user));
    });
  }
}
