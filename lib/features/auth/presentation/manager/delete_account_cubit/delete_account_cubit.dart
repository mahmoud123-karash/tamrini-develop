import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/auth/domain/repo/login_repo.dart';
import 'delete_account_states.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountStates> {
  DeleteAccountCubit(this.loginRepo) : super(InitialDeleteAccountState());
  static DeleteAccountCubit get(context) => BlocProvider.of(context);

  final LoginRepo loginRepo;

  void deleteAccount() async {
    emit(LoadingDeleteAccountState());
    var result = await loginRepo.deleteAccount();
    result.fold(
      (message) {
        emit(ErrorDeleteAccountState(message));
      },
      (message) {
        if (message == 're') {
          emit(ReAuthAccountState());
        } else {
          emit(SuccessDeleteAccountState());
        }
      },
    );
  }
}
