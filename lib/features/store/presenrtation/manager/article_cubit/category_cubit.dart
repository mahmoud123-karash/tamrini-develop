import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/store/domain/repo/store_repo.dart';
import 'package:tamrini/features/store/presenrtation/manager/article_cubit/category_states.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit(this.storeRepo) : super(InitialCategoriesState());

  static CategoryCubit get(context) => BlocProvider.of(context);

  final StoreRepo storeRepo;

  void getData() async {
    emit(LoadingGetCategoriesState());
    var result = await storeRepo.getCategories();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetCategoriesState(message));
      },
      (list) {
        emit(SucessGetCategoriesState(list));
      },
    );
  }
}
