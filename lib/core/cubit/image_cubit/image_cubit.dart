import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';

class ImageCubit extends Cubit<ImageStates> {
  ImageCubit() : super(InitialImageState());
  static ImageCubit get(context) => BlocProvider.of(context);

  List<String> paths = [];
  final ImagePicker picker = ImagePicker();

  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      paths.add(image.path);
      emit(SucessPickImageState());
    } else {
      emit(ErrorPickImageState());
    }
  }

  void imgsFromGallery() async {
    try {
      List<XFile> pickedFile = await picker.pickMultiImage(imageQuality: 50);
      for (var element in pickedFile) {
        paths.add(element.path);
      }
      emit(SucessPickMultiImageState());
    } catch (e) {
      emit(ErrorPickImageState());
    }
  }

  void videoFromGallery() async {
    final vedio = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (vedio != null) {
      paths.add(vedio.path);
      emit(SucessPickVedioState());
    } else {
      emit(ErrorPickImageState());
    }
  }

  void removeImage({required String path}) {
    paths.remove(path);
    emit(SucessRemoveImageState());
  }

  List<String> images = [];
  void removeOldImage(int index) {
    List<String> updatedImages = List.from(images);
    updatedImages.removeAt(index);
    images = updatedImages;
    emit(SucessRemoveOldImageState());
  }

  void clearPaths() {
    paths.clear();
    images.clear();
    emit(SucessRemoveImageState());
  }
}
