import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/domain/repo/food_repo.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/supplement_model/supplement_model.dart';

class SupplementCubit extends Cubit<SupplementStates> {
  SupplementCubit(this.foodRepo) : super(InitialSupplementState());

  static SupplementCubit get(context) => BlocProvider.of(context);

  final FoodRepo foodRepo;

  List<SupplementModel> models = [];

  SupplementModel? getSupplement(id) {
    List<SupplementModel> list =
        models.where((element) => element.id == id).toList();
    if (list.isEmpty) {
      return null;
    } else {
      return list.first;
    }
  }

  SupplementData? getSupplementData(supplementDataId) {
    List<SupplementData> list = [];
    for (var element in models) {
      list.addAll(element.data);
    }
    List<SupplementData> finalList =
        list.where((element) => element.id == supplementDataId).toList();
    if (finalList.isEmpty) {
      return null;
    } else {
      return finalList.first;
    }
  }

  void getData() async {
    emit(LoadingGetSupplementState());
    var result = await foodRepo.get();
    result.fold(
      (message) {
        emit(ErrorGetSupplementState(message));
      },
      (list) {
        models = list;
        emit(SucessGetSupplementState(list));
      },
    );
  }

  void addCategory({
    required String title,
    required String imagePath,
    required BuildContext context,
  }) async {
    emit(LoadingGetSupplementState());
    var result = await foodRepo.addCategory(imagePath: imagePath, title: title);
    result.fold(
      (message) {
        emit(ErrorGetSupplementState(message));
      },
      (list) {
        models = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
        emit(SucessGetSupplementState(list));
      },
    );
  }

  void editCategory({
    required String title,
    required String imagePath,
    required SupplementModel oldModel,
    required BuildContext context,
  }) async {
    emit(LoadingGetSupplementState());
    var result = await foodRepo.editCategory(
      imagePath: imagePath,
      title: title,
      oldModel: oldModel,
    );
    result.fold(
      (message) {
        emit(ErrorGetSupplementState(message));
      },
      (list) {
        models = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetSupplementState(list));
      },
    );
  }

  void removeCategory({
    required SupplementModel oldModel,
    required BuildContext context,
  }) async {
    var result = await foodRepo.removeCategory(
      oldModel: oldModel,
    );
    result.fold(
      (message) {
        getData();
        emit(ErrorGetSupplementState(message));
      },
      (list) {
        models = list;
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessGetSupplementState(list));
      },
    );
  }

  void addSupplement({
    required String id,
    required String imagePath,
    required String title,
    required String description,
    required BuildContext context,
  }) async {
    emit(LoadingGetSupplementState());
    var result = await foodRepo.addSupplement(
      category: getSupplement(id)!,
      imagePath: imagePath,
      title: title,
      description: description,
    );
    result.fold(
      (message) {
        emit(ErrorGetSupplementState(message));
      },
      (list) {
        models = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
        emit(SucessGetSupplementState(list));
      },
    );
  }

  void editSupplement({
    required String id,
    required SupplementData oldModel,
    required String imagePath,
    required String title,
    required String description,
    required BuildContext context,
  }) async {
    emit(LoadingGetSupplementState());
    var result = await foodRepo.editSupplement(
      oldModel: oldModel,
      category: getSupplement(id)!,
      imagePath: imagePath,
      title: title,
      description: description,
    );
    result.fold(
      (message) {
        emit(ErrorGetSupplementState(message));
      },
      (list) {
        models = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetSupplementState(list));
      },
    );
  }

  void removeSupplement({
    required String id,
    required SupplementData oldModel,
    required String message,
  }) async {
    emit(LoadingGetSupplementState());
    var result = await foodRepo.removeSupplement(
      oldModel: oldModel,
      category: getSupplement(id)!,
    );
    result.fold(
      (message) {
        getData();
        emit(ErrorGetSupplementState(message));
      },
      (list) {
        models = list;
        showToast(message);
        emit(SucessGetSupplementState(list));
      },
    );
  }
}
