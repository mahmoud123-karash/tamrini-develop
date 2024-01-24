import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';

class ImageCubit extends Cubit<ImageStates> {
  ImageCubit() : super(InitialImageState());
  static ImageCubit get(context) => BlocProvider.of(context);
  final ImagePicker picker = ImagePicker();

  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(SuceessPickImageState(image));
    } else {
      emit(ErrorPickImageState());
    }
  }

  void imgsFromGallery() async {
    try {
      List<File> photos = [];
      List<XFile> pickedFile = await picker.pickMultiImage(imageQuality: 50);
      pickedFile.map((e) {
        photos.add(File(e.path));
      });
      emit(SuceessPickMultiImageState(photos));
    } catch (e) {
      emit(ErrorPickImageState());
    }
  }

  void videoFromGallery() async {
    final vedio = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (vedio != null) {
      emit(SuceessPickVedioState(vedio));
    } else {
      emit(ErrorPickImageState());
    }
  }
}
