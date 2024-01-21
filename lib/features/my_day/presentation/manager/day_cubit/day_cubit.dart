import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/domain/repo/my_day_repo.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_states.dart';

import '../../../data/models/day_model/calculator_model.dart';

class DayCubit extends Cubit<DayStates> {
  DayCubit(this.myDayRepo) : super(InitialDayState());

  static DayCubit get(context) => BlocProvider.of(context);

  DayModel getDay({required String id}) {
    var box = Hive.box<DayModel>(dayBox);
    List<DayModel> list =
        box.values.toList().where((element) => element.id == id).toList();
    return list.first;
  }

  final MyDayRepo myDayRepo;
  void getData() async {
    emit(LoadingGetDayState());
    var result = await myDayRepo.getData();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetDayState(message));
      },
      (list) {
        emit(SucessGetDayState(list));
      },
    );
  }

  void addToday() async {
    var result = await myDayRepo.addToday();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetDayState(message));
      },
      (list) {
        emit(SucessGetDayState(list));
      },
    );
  }

  void recalulate({
    required CalculatorModel calculatorModel,
    required String id,
  }) async {
    emit(LoadingGetDayState());
    var result = await myDayRepo.reCalculate(
        model: getDay(id: id), calculatorModel: calculatorModel);
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetDayState(message));
      },
      (list) {
        emit(SucessGetDayState(list));
      },
    );
  }
}
