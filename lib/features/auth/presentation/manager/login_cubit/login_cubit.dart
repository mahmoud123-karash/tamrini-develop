import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/auth/domain/repo/login_repo.dart';
import 'package:tamrini/features/auth/presentation/manager/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.loginRepo) : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);

  final LoginRepo loginRepo;

  void loginWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    emit(LoadingLoginState());
    var result = await loginRepo.loginwithEmailAndPass(
      email: email,
      password: password,
    );
    result.fold((message) {
      emit(ErrorLoginState(message));
    }, (uid) {
      emit(SuccessLoginState(uid));
    });
  }
}
