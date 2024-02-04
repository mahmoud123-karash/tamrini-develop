import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/domain/repo/food_repo.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/supplement_model/supplement_model.dart';

class SupplementCubit extends Cubit<SupplementStates> {
  SupplementCubit(this.foodRepo) : super(InitialSupplementState());

  static SupplementCubit get(context) => BlocProvider.of(context);

  final FoodRepo foodRepo;

  void getData() async {
    emit(LoadingGetSupplementState());
    var result = await foodRepo.get();
    result.fold(
      (message) {
        emit(ErrorGetSupplementState(message));
      },
      (list) {
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
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessGetSupplementState(list));
      },
    );
  }
}
