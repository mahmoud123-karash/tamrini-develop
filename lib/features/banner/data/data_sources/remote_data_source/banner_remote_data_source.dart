import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<List<BannerModel>> get();
}

class BannerRemoteDataSourceImpl extends BannerRemoteDataSource {
  @override
  Future<List<BannerModel>> get() async {
    List<BannerModel> list = [];
    var data = await FirebaseFirestore.instance.collection('banners').get();

    for (var element in data.docs) {
      list.add(BannerModel.fromjson(element.data()));
    }
    return list;
  }
}
