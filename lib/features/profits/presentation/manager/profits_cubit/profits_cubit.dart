import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/features/profits/domain/repo/profits_repo.dart';
import 'package:tamrini/features/profits/presentation/manager/profits_cubit/profits_states.dart';

class ProfitsCubit extends Cubit<ProfitsStates> {
  ProfitsCubit(this.profitsRepo) : super(InitialProfitsState());
  static ProfitsCubit get(context) => BlocProvider.of(context);
  final ProfitsRepo profitsRepo;

  List<ProfitsModel> adminList = [];
  void getData() async {
    String userType = CacheHelper.getData(key: 'usertype');
    if (userType == UserType.admin) {
      emit(LoadingGetProfitsRequestsState());
      var result = await profitsRepo.get();
      result.fold((message) {
        emit(ErrorGetProfitsRequestsState(message));
      }, (list) {
        adminList = list;
        emit(SuccessGetProfitsRequestsState(list));
      });
    }
  }

  void accept({
    required ProfitsModel model,
  }) async {
    emit(LoadingGetProfitsRequestsState());
    var result = await profitsRepo.accept(model: model);
    result.fold((message) {
      emit(ErrorGetProfitsRequestsState(message));
    }, (list) {
      adminList = list;
      emit(SuccessGetProfitsRequestsState(list));
    });
  }

  void removeRequest({required String id}) async {
    emit(LoadingGetProfitsRequestsState());
    var result = await profitsRepo.removeRequest(id: id);
    result.fold((message) {
      emit(ErrorGetProfitsRequestsState(message));
    }, (list) {
      adminList = list;
      emit(SuccessGetProfitsRequestsState(list));
    });
  }

  List<ProfitsModel> pList = [];
  void getmyRequests({bool isUpdate = false, required String uid}) async {
    String userType = CacheHelper.getData(key: 'usertype');
    if (userType != UserType.admin) {
      if (pList.isNotEmpty && !isUpdate) {
        emit(SuccessGetProfitsRequestsState(pList));
      } else {
        emit(LoadingGetProfitsRequestsState());
        var result = await profitsRepo.getMyRequests(uid: uid);
        result.fold((message) {
          emit(ErrorGetProfitsRequestsState(message));
        }, (list) {
          pList = list;
          emit(SuccessGetProfitsRequestsState(list));
        });
      }
    }
  }

  void request({
    required num amount,
    required String id,
    required String cashNumber,
  }) async {
    emit(LoadingGetProfitsRequestsState());
    var result = await profitsRepo.request(
      amount: amount,
      id: id,
      cashNumber: cashNumber,
    );
    result.fold((message) {
      emit(ErrorGetProfitsRequestsState(message));
    }, (list) {
      pList = list;
      emit(SuccessGetProfitsRequestsState(list));
    });
  }
}
