import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/navBar/domain/repo/navbar_repo.dart';
import 'package:tamrini/features/navBar/presentation/manager/update_cubit/update_states.dart';

class UpdateCubit extends Cubit<UpdateStates> {
  UpdateCubit(this.navBarRepo) : super(InitailUpdateState());
  static UpdateCubit get(context) => BlocProvider.of(context);

  final NavBarRepo navBarRepo;

  void update() {
    try {
      navBarRepo.update();
      emit(SuccessUpdateState());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(ErrorUpdateState());
    }
  }
}
