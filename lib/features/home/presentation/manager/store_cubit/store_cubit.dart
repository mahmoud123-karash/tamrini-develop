import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/domain/repo/home_repo.dart';
import 'package:tamrini/features/home/presentation/manager/store_cubit/store_states.dart';

class StoreCubit extends Cubit<StoreStates> {
  StoreCubit(this.homeRepo) : super(InitialStoresState());

  static StoreCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;

  void getData() async {
    emit(LoadingGetStoresState());
    var result = await homeRepo.getStores();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetStoresState(message));
      },
      (list) {
        emit(SucessGetStoresState(list));
      },
    );
  }
}
