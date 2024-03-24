import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/domain/use_cases/ban_user_case.dart';
import 'package:tamrini/features/questions/presentation/manager/ban_cubit/ban_states.dart';

class BanCubit extends Cubit<BanStates> {
  BanCubit(this.banUserUseCase) : super(InitialBanState());

  static BanCubit get(context) => BlocProvider.of(context);

  final BanUserUseCase banUserUseCase;

  void banUser({
    required bool isBanned,
    required String uid,
    required String message,
  }) async {
    emit(LoadingBanState());

    var result = await banUserUseCase.ban(uid: uid, isBanned: isBanned);
    result.fold(
      (message) {
        emit(ErrorBanState(message));
      },
      (success) {
        showToast(message);
        emit(SucessBanState());
      },
    );
  }
}
