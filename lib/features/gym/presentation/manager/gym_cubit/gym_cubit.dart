import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/domain/repo/gym_repo.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/generated/l10n.dart';

class GymCubit extends Cubit<GymStates> {
  GymCubit(this.gymRepo) : super(InitialGymState());

  static GymCubit get(context) => BlocProvider.of(context);

  final GymRepo gymRepo;
  List<GymModel> gyms = [];

  List<GymModel> getUserGym(uid) {
    List<GymModel> list =
        gyms.where((element) => element.ownerUid == uid).toList();
    return list;
  }

  List<GymModel> getGym(id) {
    List<GymModel> list = gyms.where((element) => element.id == id).toList();
    return list;
  }

  void getData({
    required bool update,
  }) async {
    emit(LoadingGetGymsState());
    var result = await gymRepo.getGyms(update: update);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetGymsState(message));
      },
      (list) {
        gyms = list;
        emit(SucessGetGymsState(list));
      },
    );
  }

  void addGym({
    required List<String> paths,
    required String name,
    required String description,
    required int price,
    required double lat,
    required double long,
    required BuildContext context,
  }) async {
    emit(LoadingGetGymsState());
    var result = await gymRepo.addGym(
      paths: paths,
      name: name,
      description: description,
      price: price,
      lat: lat,
      long: long,
    );
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetGymsState(message));
      },
      (list) {
        gyms = list;
        showSnackBar(context, S.of(context).success_add_a);
        Navigator.pop(context);
        emit(SucessGetGymsState(list));
      },
    );
  }

  void editGym({
    required List<String> paths,
    required String name,
    required String description,
    required int price,
    required double lat,
    required double long,
    required GymModel oldModel,
    required List<String> images,
    required BuildContext context,
  }) async {
    emit(LoadingGetGymsState());
    var result = await gymRepo.editGym(
        paths: paths,
        name: name,
        description: description,
        price: price,
        lat: lat,
        long: long,
        oldModel: oldModel,
        images: images);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetGymsState(message));
      },
      (list) {
        gyms = list;
        showSnackBar(context, S.of(context).success_edit_a);
        Navigator.pop(context);
        emit(SucessGetGymsState(list));
      },
    );
  }

  void removeGym({
    required List<String> images,
    required String id,
    required BuildContext context,
  }) async {
    var result = await gymRepo.removeGym(id: id, images: images);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetGymsState(message));
      },
      (list) {
        gyms = list;
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessGetGymsState(list));
      },
    );
  }
}
