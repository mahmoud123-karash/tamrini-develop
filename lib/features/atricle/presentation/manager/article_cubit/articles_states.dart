import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';

abstract class ArticlesStates {}

class InitialArticlesState extends ArticlesStates {}

class LoadingGetArticlesState extends ArticlesStates {}

class SucessGetArticlesState extends ArticlesStates {
  final List<ArticleModel> list;

  SucessGetArticlesState(this.list);
}

class ErrorGetArticlesState extends ArticlesStates {
  final String message;

  ErrorGetArticlesState(this.message);
}
