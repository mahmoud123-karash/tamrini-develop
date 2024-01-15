import 'package:image_picker/image_picker.dart';

abstract class ImageStates {}

class InitialImageState extends ImageStates {}

class LoadingPickImageState extends ImageStates {}

class SuceesPickImageState extends ImageStates {
  final XFile image;

  SuceesPickImageState(this.image);
}

class ErrorPickImageState extends ImageStates {}
