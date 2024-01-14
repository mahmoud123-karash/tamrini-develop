import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/profile/domain/repo/profile_repo.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.profileRepo) : super(InitialProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final ProfileRepo profileRepo;

  void getProfile() async {
    emit(LoadingGetProfileState());
    var result = await profileRepo.getProfile();
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetProfileState(message));
      },
      (model) {
        emit(SucessGetProfileState(model));
      },
    );
  }
}
