import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/banner/domain/repo/banner_repo.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_states.dart';

class BannerCubit extends Cubit<BannerStates> {
  BannerCubit(this.bannerRepo) : super(InitialBannerState());

  static BannerCubit get(context) => BlocProvider.of(context);

  final BannerRepo bannerRepo;

  void getData() async {
    emit(LoadingGetBannersState());
    var result = await bannerRepo.getBanners();
    result.fold(
      (message) {
        emit(ErrorGetBannersState(message));
      },
      (list) {
        emit(SucessGetBannersState(list));
      },
    );
  }

  void addBanner({
    required String uri,
    required String imagePath,
  }) async {
    emit(LoadingGetBannersState());
    var result = await bannerRepo.addBanner(uri: uri, imagePath: imagePath);
    result.fold(
      (message) {
        emit(ErrorGetBannersState(message));
      },
      (list) {
        emit(SucessGetBannersState(list));
      },
    );
  }

  void removeBanner({required String id}) async {
    emit(LoadingGetBannersState());
    var result = await bannerRepo.removeBanner(id: id);
    result.fold(
      (message) {
        emit(ErrorGetBannersState(message));
      },
      (list) {
        emit(SucessGetBannersState(list));
      },
    );
  }
}
