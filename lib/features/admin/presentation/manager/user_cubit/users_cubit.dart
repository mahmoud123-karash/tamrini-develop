import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/admin/domain/repo/admin_repo.dart';
import 'package:tamrini/features/admin/presentation/manager/user_cubit/users_states.dart';

class UsersCubit extends Cubit<UsersStates> {
  UsersCubit(this.adminRepo) : super(InitialUserState());

  static UsersCubit get(context) => BlocProvider.of(context);

  final AdminRepo adminRepo;

  List<UserModel> users = [];
  void getUsers() async {
    emit(LoadingGetUsersState());
    var result = await adminRepo.getUsers();
    result.fold((message) {
      emit(ErrorGetUsersState(message));
    }, (list) {
      emit(SucessGetUsersState(list));
    });
  }
}
