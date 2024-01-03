import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/features/home/presentation/manager/swiper_cubit/swiper_states.dart';

class SwiperCubit extends Cubit<SwiperStates> {
  SwiperCubit() : super(InitialSwiperState());
  static SwiperCubit get(context) => BlocProvider.of(context);

  SwiperController swiperController = SwiperController();
  void showImage() {
    emit(LoadingShowImageState());
    swiperController.move(0).then((value) {
      emit(SuccessShowImageState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorShowImageState(error));
    });
  }

  void showVedio() {
    emit(LoadingShowVedioState());
    swiperController.move(1).then((value) {
      emit(SuccessShowVedioState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorShowVedioState(error));
    });
  }

  void saveIndex(value) {
    saveSwiperIndex(value);

    emit(SaveIndexState());
  }
}
