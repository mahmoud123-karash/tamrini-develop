import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';

abstract class ProfileRemotedataSource {
  Future<ProfileModel> get();
}

class ProfileRemotedataSourceImpl extends ProfileRemotedataSource {
  @override
  Future<ProfileModel> get() async {
    String uid = CacheHelper.getData(key: 'uid');
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    GeoPoint location =
        result.data()!['location'] ?? const GeoPoint(33.312805, 44.361488);
    String address = await getAddress(location: location);
    ProfileModel model = ProfileModel.fromMap(result.data()!, address);
    var box = Hive.box<ProfileModel>(profileBox);
    box.add(model);
    return model;
  }
}
