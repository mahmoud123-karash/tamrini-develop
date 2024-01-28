import 'package:tamrini/features/store/data/models/category_model/category_model.dart';

abstract class CategoryStates {}

class InitialCategoriesState extends CategoryStates {}

class LoadingGetCategoriesState extends CategoryStates {}

class SucessGetCategoriesState extends CategoryStates {
  final List<CategoryModel> list;

  SucessGetCategoriesState(this.list);
}

class ErrorGetCategoriesState extends CategoryStates {
  final String message;

  ErrorGetCategoriesState(this.message);
}
