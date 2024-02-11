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
    required String facebookUri,
    required String instgramUri,
    required String twiterUri,
    required String address,
    required String whatsApp,
    required String path,
    required String trainerId,
  }) async {
    emit(LoadingGetProfileState());
    var result = await updateUseCase.update(
      name: name,
      email: email,
      gender: gender,
      age: age,
      whatsApp: whatsApp,
      trainerId: trainerId,
      phone: phone,
      image: image,
      isBanned: isBanned,
      facebookUri: facebookUri,
      instgramUri: instgramUri,
      twiterUri: twiterUri,
      address: address,
      path: path,
    );
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
