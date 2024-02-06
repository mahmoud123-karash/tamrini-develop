import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/store/data/data_sources/local_data_source/store_local_data_source.dart';
import 'package:tamrini/features/store/data/data_sources/remote_data_source/store_remote_data_source.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/domain/repo/store_repo.dart';
import 'package:uuid/uuid.dart';

class StoreRepoImpl extends StoreRepo {
  final StoreRemoteDataSource storeRemoteDataSource;
  final StoreLocalDataSource storeLocalDataSource;
  final DioHelper dioHelper;
  StoreRepoImpl(
      this.storeRemoteDataSource, this.storeLocalDataSource, this.dioHelper);
  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      List<CategoryModel> cachedList = storeLocalDataSource.get();
      if (cachedList.isNotEmpty) {
        return right(cachedList);
      }
      List<CategoryModel> list = await storeRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> getStores() async {
    try {
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> addStore({
    required String name,
    required String contact,
    required String imagePath,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      List files = [];
      files.add(File(imagePath));
      List<String> images = await uploadFiles(files: files);
      StoreModel model = StoreModel(
        image: images.isEmpty ? '' : images.first,
        name: name,
        storeOwnerUid: uid,
        contact: contact,
        isBanned: false,
        products: [],
      );
      await FirebaseFirestore.instance
          .collection('stores')
          .doc(uid)
          .set(model.toMap());
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> editStore({
    required String name,
    required String contact,
    required String imagePath,
    required StoreModel store,
  }) async {
    try {
      late StoreModel model;
      if (imagePath == '') {
        model = StoreModel(
          image: store.image,
          name: name,
          storeOwnerUid: store.storeOwnerUid,
          contact: contact,
          isBanned: false,
          products: store.products,
        );
      } else {
        List<String> images = await getImages(imagePath);
        if (store.image != '') {
          List<String> oldImages = [];
          oldImages.add(store.image);
          await deleteOldImages(newImages: [], oldImages: oldImages);
        }
        model = StoreModel(
          image: images.isEmpty ? '' : images.first,
          name: name,
          storeOwnerUid: store.storeOwnerUid,
          contact: contact,
          isBanned: false,
          products: store.products,
        );
      }
      await FirebaseFirestore.instance
          .collection('stores')
          .doc(store.storeOwnerUid)
          .update(model.toMap());
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<List<String>> getImages(String imagePath) async {
    List files = [];
    files.add(File(imagePath));
    List<String> images = await uploadFiles(files: files);
    return images;
  }

  @override
  Future<Either<String, List<StoreModel>>> addProduct({
    required String title,
    required String description,
    required String type,
    required num price,
    required num oldPrice,
    required bool bestSeller,
    required String imagePath,
    required StoreModel store,
  }) async {
    try {
      var uuid = const Uuid().v4();
      List<String> images = await getImages(imagePath);
      ProductModel productModel = ProductModel(
        contact: store.contact,
        ownerUid: store.storeOwnerUid,
        title: title,
        description: description,
        id: uuid,
        type: type,
        image: images.isEmpty ? '' : images.first,
        price: price,
        oldPrice: oldPrice,
        available: true,
        bestSeller: bestSeller,
        rating: [],
      );
      List<ProductModel> products = store.products ?? [];
      products.add(productModel);
      StoreModel model = StoreModel(
        image: store.image,
        name: store.name,
        storeOwnerUid: store.storeOwnerUid,
        contact: store.contact,
        isBanned: store.isBanned,
        products: products,
      );
      await FirebaseFirestore.instance
          .collection('stores')
          .doc(store.storeOwnerUid)
          .update(model.toMap());
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> editProduct({
    required String title,
    required String description,
    required String type,
    required num price,
    required num oldPrice,
    required bool bestSeller,
    required bool available,
    required String imagePath,
    required StoreModel store,
    required ProductModel oldModel,
  }) async {
    try {
      late ProductModel productModel;
      if (imagePath == '') {
        productModel = ProductModel(
          contact: store.contact,
          ownerUid: store.storeOwnerUid,
          title: title,
          description: description,
          id: oldModel.id,
          type: type,
          image: oldModel.image,
          price: price,
          oldPrice: oldPrice,
          available: available,
          bestSeller: bestSeller,
          rating: oldModel.rating,
        );
      } else {
        List<String> images = await getImages(imagePath);
        if (oldModel.image != '') {
          List<String> oldImages = [];
          oldImages.add(oldModel.image);
          await deleteOldImages(newImages: images, oldImages: oldImages);
        }
        productModel = ProductModel(
          contact: store.contact,
          ownerUid: store.storeOwnerUid,
          title: title,
          description: description,
          id: oldModel.id,
          type: type,
          image: images.isEmpty ? '' : images.first,
          price: price,
          oldPrice: oldPrice,
          available: available,
          bestSeller: bestSeller,
          rating: oldModel.rating,
        );
      }
      List<ProductModel> products = store.products ?? [];
      products.remove(oldModel);
      products.add(productModel);
      StoreModel model = StoreModel(
        image: store.image,
        name: store.name,
        storeOwnerUid: store.storeOwnerUid,
        contact: store.contact,
        isBanned: store.isBanned,
        products: products,
      );
      await FirebaseFirestore.instance
          .collection('stores')
          .doc(store.storeOwnerUid)
          .update(model.toMap());
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> removeProduct({
    required ProductModel oldModel,
    required StoreModel store,
  }) async {
    try {
      List<ProductModel> products = store.products ?? [];
      products.remove(oldModel);
      StoreModel model = StoreModel(
        image: store.image,
        name: store.name,
        storeOwnerUid: store.storeOwnerUid,
        contact: store.contact,
        isBanned: false,
        products: products,
      );
      await FirebaseFirestore.instance
          .collection('stores')
          .doc(store.storeOwnerUid)
          .update(model.toMap());
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> banStore({
    required StoreModel store,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('stores')
          .doc(store.storeOwnerUid)
          .update(
        {
          "isBanned": !store.isBanned,
        },
      );
      sendNotification(
        isBanned: !store.isBanned,
        owneruid: store.storeOwnerUid,
        storeId: store.storeOwnerUid,
      );
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification({
    required bool isBanned,
    required String owneruid,
    required String storeId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'store',
      senderUid: adminUid,
      title: isBanned == true ? 'ban_stotre' : 'no_ban_store',
      body: '',
      type: 'notification',
      uid: storeId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(owneruid)
        .collection('data')
        .add(
          notification.toJson(),
        );
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(owneruid)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'المتجر',
        body: isBanned == false
            ? 'تم رفع التقييد عن المتجر الخاص بك'
            : 'تم تقييد المتجر الخاص بك',
        data: {
          "type": "notification",
          "subType": "store",
          "uid": storeId,
        },
      );
    }
  }
}
