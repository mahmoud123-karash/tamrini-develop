import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/nutrition/domain/repo/nutrition_repo.dart';
import 'package:tamrini/features/nutrition/presentation/manager/classification_cubit/classification_states.dart';
import 'package:tamrini/generated/l10n.dart';

class ClassificationCubit extends Cubit<ClassificationStates> {
  ClassificationCubit(this.nuritionRepo) : super(InitialClassificationState());

  static ClassificationCubit get(context) => BlocProvider.of(context);

  final NuritionRepo nuritionRepo;

  void getData() async {
    emit(LoadingGetClassificationState());
    var result = await nuritionRepo.getClassifications();
    result.fold(
      (message) {
        emit(ErrorGetClassificationState(message));
      },
      (list) {
        emit(SucessGetClassificationState(list));
      },
    );
  }

  void addClassifications({
    required String name,
    required BuildContext context,
  }) async {
    var result = await nuritionRepo.addClassifications(name: name);
    result.fold(
      (message) {
        emit(ErrorGetClassificationState(message));
      },
      (list) {
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
        emit(SucessGetClassificationState(list));
      },
    );
  }

  void editClassifications({
    required String name,
    required String id,
    required BuildContext context,
  }) async {
    var result = await nuritionRepo.editClassifications(name: name, id: id);
    result.fold(
      (message) {
        emit(ErrorGetClassificationState(message));
      },
      (list) {
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetClassificationState(list));
      },
    );
  }
}
