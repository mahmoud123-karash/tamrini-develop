import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/profile/domain/repo/profile_repo.dart';
import 'package:tamrini/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.profileRepo, this.updateUseCase)
      : super(InitialProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final ProfileRepo profileRepo;
  final UpdateUseCase updateUseCase;

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

  void updateProfile({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String phone,
    required String image,
    required bool isBanned,
    required bool isSubscribedToGym,
    required bool isSubscribedToTrainer,
  }) async {
    emit(LoadingGetProfileState());
    var result = await updateUseCase.update(
        name: name,
        email: email,
        gender: gender,
        isSubscribedToGym: isSubscribedToGym,
        isSubscribedToTrainer: isSubscribedToTrainer,
        age: age,
        phone: phone,
        image: image,
        isBanned: isBanned);
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
