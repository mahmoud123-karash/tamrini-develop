import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/domain/repo/my_day_repo.dart';
import 'package:tamrini/features/my_day/presentation/manager/article_cubit/day_states.dart';

class DayCubit extends Cubit<DayStates> {
  DayCubit(this.myDayRepo) : super(InitialDayState());

  static DayCubit get(context) => BlocProvider.of(context);

  List<DayModel> dayList = [];
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
        dayList = list;
        emit(SucessGetDayState(list));
      },
    );
  }
}
