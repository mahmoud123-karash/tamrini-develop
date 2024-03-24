import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialUserState());

  static UserCubit get(context) => BlocProvider.of(context);

  var fireStore = FirebaseFirestore.instance.collection('users');
  void getUser({required String uid}) async {
    emit(LoadingGetUserState());
    try {
      var result = await fireStore.doc(uid).get();
      UserModel model = UserModel.fromMap(result.data()!, result.id);
      if (!isClosed) {
        emit(SucessGetUserState(model));
      }
    } catch (e) {
      emit(ErrorGetUserState(e.toString()));
    }
  }
}
