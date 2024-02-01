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
        List<GymModel> models = clearBannedGym(list);
        emit(SucessGetGymsState(models));
      },
    );
  }

  List<GymModel> clearBannedGym(List<GymModel> list) {
    List<GymModel> models = [];
    for (var element in list) {
      if (!element.isBanned) {
        models.add(element);
      }
    }
    return models;
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
        List<GymModel> models = clearBannedGym(list);

        emit(SucessGetGymsState(models));
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
      images: images,
    );
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetGymsState(message));
      },
      (list) {
        gyms = list;
        showSnackBar(context, S.of(context).success_edit_a);
        Navigator.pop(context);
        List<GymModel> models = clearBannedGym(list);
        emit(SucessGetGymsState(models));
      },
    );
  }

  void banGym({
    required String id,
    required String ownerId,
    required bool isBannd,
    required BuildContext context,
  }) async {
    var result =
        await gymRepo.banGym(gymId: id, ownerId: ownerId, isBannd: isBannd);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetGymsState(message));
      },
      (list) {
        gyms = list;
        showSnackBar(
          context,
          isBannd
              ? S.of(context).ban_sucess_gym
              : S.of(context).no_ban_suvccess_gym,
        );
        List<GymModel> models = clearBannedGym(list);
        emit(SucessGetGymsState(models));
      },
    );
  }
}
