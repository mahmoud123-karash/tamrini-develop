import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/features/profile/domain/repo/profile_repo.dart';
import 'package:tamrini/features/profile/presentation/manager/image_cubit/image_states.dart';

class ImageCubit extends Cubit<ImageStates> {
  ImageCubit(this.profileRepo) : super(InitialImageState());
  static ImageCubit get(context) => BlocProvider.of(context);
  final ProfileRepo profileRepo;

  void pichImage() async {
    emit(LoadingPickImageState());
    var result = await profileRepo.pickProfileImage();
    result.fold((message) {
      emit(ErrorPickImageState());
    }, (pickedImage) {
      saveImagePath(pickedImage.path);
      emit(SuceesPickImageState(pickedImage));
    });
  }
}
