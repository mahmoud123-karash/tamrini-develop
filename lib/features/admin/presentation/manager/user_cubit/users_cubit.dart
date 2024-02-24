import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/admin/domain/repo/admin_repo.dart';
import 'package:tamrini/features/admin/presentation/manager/user_cubit/users_states.dart';

class UsersCubit extends Cubit<UsersStates> {
  UsersCubit(this.adminRepo) : super(InitialUserState());

  static UsersCubit get(context) => BlocProvider.of(context);

  final AdminRepo adminRepo;

  List<UserModel> users = [];

  List<UserModel> getU({required String userType}) {
    return users.where((element) => element.role == userType).toList();
  }

  void getUsers({required String userType}) async {
    List<UserModel> localList = getU(userType: userType);
    if (localList.isNotEmpty) {
      if (userType == UserType.user) {
        emit(SucessGetUsersState(users));
      } else {
        emit(SucessGetUsersState(localList));
      }
    } else {
      emit(LoadingGetUsersState());
      var result = await adminRepo.getUsers(userType: userType);
      result.fold(
        (message) {
          emit(ErrorGetUsersState(message));
        },
        (list) {
          users.addAll(list);
          if (userType == UserType.user) {
            emit(SucessGetUsersState(users));
          } else {
            emit(SucessGetUsersState(list));
          }
        },
      );
    }
  }
}
