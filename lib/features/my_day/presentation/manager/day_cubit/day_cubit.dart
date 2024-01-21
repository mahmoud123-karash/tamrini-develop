import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/my_day/domain/repo/my_day_repo.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_states.dart';

class DayCubit extends Cubit<DayStates> {
  DayCubit(this.myDayRepo) : super(InitialDayState());

  static DayCubit get(context) => BlocProvider.of(context);

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
}
