import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/subscription_model/subscription_model.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialUserState());

  static UserCubit get(context) => BlocProvider.of(context);

  void getUser({required String uid}) async {
    emit(LoadingGetUserState());
    try {
      var result =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      GeoPoint location =
          result.data()!['location'] ?? const GeoPoint(33.312805, 44.361488);
      String address = await getAddress(location: location);
      UserModel model = UserModel.fromMap(result.data()!, result.id, address);
      if (!isClosed) {
        emit(SucessGetUserState(model));
      }
    } catch (e) {
      emit(ErrorGetUserState(e.toString()));
    }
  }

  void getSubscriptions() async {
    emit(LoadingGetUserSubState());
    try {
      List<SubscriptionModel> list = [];
      String uid = CacheHelper.getData(key: 'uid');
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Subscriptions')
          .get();
      for (var element in result.docs) {
        SubscriptionModel model = SubscriptionModel.fromJson(element.data());
        list.add(model);
      }
      if (!isClosed) {
        emit(SucessGetUserSubState(list));
      }
    } catch (e) {
      emit(ErrorGetUserSubState(e.toString()));
    }
  }
}
