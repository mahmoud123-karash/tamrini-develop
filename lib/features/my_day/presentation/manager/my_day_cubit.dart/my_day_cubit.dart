import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/my_day/presentation/manager/my_day_cubit.dart/my_day_states.dart';

class MyDayCubit extends Cubit<MyDayStates> {
  MyDayCubit() : super(InitialMyDayState());

  static MyDayCubit get(context) => BlocProvider.of(context);
}
