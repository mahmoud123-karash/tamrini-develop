import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/auth/domain/use_cases/register_use_case.dart';

import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this.registerUseCase) : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  final RegisterUseCase registerUseCase;

  void registerUser({
    required String name,
    required String email,
    required String phone,
    required int age,
    required String gender,
    required String password,
  }) async {
    emit(LoadingRegisterState());
    var result = await registerUseCase.signUp(
      name: name,
      email: email,
      phone: phone,
      age: age,
      gender: gender,
      password: password,
    );

    result.fold(
      (message) {
        emit(ErrorRegisterState(message));
      },
      (created) {
        emit(SuccessRegisterState());
      },
    );
  }
}
