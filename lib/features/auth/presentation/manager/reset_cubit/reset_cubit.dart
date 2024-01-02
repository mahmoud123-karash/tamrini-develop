import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/auth/presentation/manager/reset_cubit/reset_states.dart';

class ResetCubit extends Cubit<ResetStates> {
  ResetCubit() : super(InitialResetState());

  static ResetCubit get(context) => BlocProvider.of(context);

  void resetPass({required String email}) {
    emit(LoadingResetState());
    FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: email,
    )
        .then((value) {
      emit(SuccessResetState());
    }).catchError((error) {
      emit(ErrorResetState(error));
    });
  }
}
