import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';

abstract class DayStates {}

class InitialDayState extends DayStates {}

class LoadingGetDayState extends DayStates {}

class SucessGetDayState extends DayStates {
  final List<DayModel> list;

  SucessGetDayState(this.list);
}

class ErrorGetDayState extends DayStates {
  final String message;

  ErrorGetDayState(this.message);
}
