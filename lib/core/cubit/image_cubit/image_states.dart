import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class ImageStates {}

class InitialImageState extends ImageStates {}

class SuceessPickImageState extends ImageStates {
  final XFile image;
  SuceessPickImageState(this.image);
}

class SuceessPickMultiImageState extends ImageStates {
  final List<File> files;
  SuceessPickMultiImageState(this.files);
}

class SuceessPickVedioState extends ImageStates {
  final XFile vedio;
  SuceessPickVedioState(this.vedio);
}

class ErrorPickImageState extends ImageStates {}
