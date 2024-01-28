import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/domain/repo/store_repo.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';

class StoreCubit extends Cubit<StoreStates> {
  StoreCubit(this.storeRepo) : super(InitialStoresState());

  static StoreCubit get(context) => BlocProvider.of(context);

  final StoreRepo storeRepo;

  List<StoreModel> stores = [];

  List<StoreModel> getStore(uid) {
    List<StoreModel> list =
        stores.where((element) => element.storeOwnerUid == uid).toList();
    return list;
  }

  void getData() async {
    emit(LoadingGetStoresState());
    var result = await storeRepo.getStores();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetStoresState(message));
      },
      (list) {
        stores = list;
        emit(SucessGetStoresState(list));
      },
    );
  }
}
