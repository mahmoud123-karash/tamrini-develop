import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/domain/repo/store_repo.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../views/store_owner_screen.dart';

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

  ProductModel? getProduct(id) {
    List<ProductModel> list = [];
    for (var element in stores) {
      list.addAll(
          element.products!.where((element) => element.id == id).toList());
    }
    if (list.isEmpty) {
      return null;
    }
    return list.first;
  }

  void getData() async {
    emit(LoadingGetStoresState());
    var result = await storeRepo.getStores();
    result.fold(
      (message) {
        emit(ErrorGetStoresState(message));
      },
      (list) {
        stores = list;
        emit(SucessGetStoresState(list));
      },
    );
  }

  void addStore({
    required String name,
    required String contact,
    required String imagePath,
    required BuildContext context,
  }) async {
    emit(LoadingGetStoresState());
    var result = await storeRepo.addStore(
        name: name, contact: contact, imagePath: imagePath);
    result.fold(
      (message) {
        emit(ErrorGetStoresState(message));
      },
      (list) {
        stores = list;
        showSnackBar(context, S.of(context).success_add_a);
        navigateToAndReplace(context, const StoreOwnerScreen());
        emit(SucessGetStoresState(list));
      },
    );
  }

  void editStore({
    required String name,
    required String contact,
    required String imagePath,
    required StoreModel model,
    required BuildContext context,
  }) async {
    emit(LoadingGetStoresState());
    var result = await storeRepo.editStore(
      name: name,
      contact: contact,
      imagePath: imagePath,
      store: model,
    );
    result.fold(
      (message) {
        emit(ErrorGetStoresState(message));
      },
      (list) {
        stores = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetStoresState(list));
      },
    );
  }

  bool isSale = false;
  bool isBestSeller = false;
  bool available = true;
  String productType = '';

  void addProduct({
    required String title,
    required String description,
    required num price,
    required num oldPrice,
    required String imagePath,
    required StoreModel store,
    required BuildContext context,
  }) async {
    emit(LoadingGetStoresState());
    var result = await storeRepo.addProduct(
      title: title,
      description: description,
      type: productType,
      price: price,
      oldPrice: oldPrice,
      bestSeller: isBestSeller,
      imagePath: imagePath,
      store: store,
    );
    result.fold(
      (message) {
        emit(ErrorGetStoresState(message));
      },
      (list) {
        stores = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
        emit(SucessGetStoresState(list));
      },
    );
  }

  void editProduct({
    required String title,
    required String description,
    required num price,
    required num oldPrice,
    required String imagePath,
    required StoreModel store,
    required ProductModel oldModel,
    required BuildContext context,
  }) async {
    emit(LoadingGetStoresState());
    var result = await storeRepo.editProduct(
      title: title,
      description: description,
      type: productType,
      price: price,
      oldPrice: oldPrice,
      bestSeller: isBestSeller,
      imagePath: imagePath,
      store: store,
      available: available,
      oldModel: oldModel,
    );
    result.fold(
      (message) {
        emit(ErrorGetStoresState(message));
      },
      (list) {
        stores = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetStoresState(list));
      },
    );
  }

  void removeProduct({
    required StoreModel store,
    required ProductModel oldModel,
    required BuildContext context,
  }) async {
    var result = await storeRepo.removeProduct(
      store: store,
      oldModel: oldModel,
    );
    result.fold(
      (message) {
        getData();
        emit(ErrorGetStoresState(message));
      },
      (list) {
        stores = list;
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessGetStoresState(list));
      },
    );
  }
}
