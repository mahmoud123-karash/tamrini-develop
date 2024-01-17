import '../../../data/models/nutrition_model.dart/classification_model.dart';

abstract class ClassificationStates {}

class InitialClassificationState extends ClassificationStates {}

class LoadingGetClassificationState extends ClassificationStates {}

class SucessGetClassificationState extends ClassificationStates {
  final List<ClassificationModel> list;

  SucessGetClassificationState(this.list);
}

class ErrorGetClassificationState extends ClassificationStates {
  final String message;

  ErrorGetClassificationState(this.message);
}
