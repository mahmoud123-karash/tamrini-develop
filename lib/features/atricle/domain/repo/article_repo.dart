import 'package:dartz/dartz.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';

abstract class ArticleRepo {
  Future<Either<String, List<ArticleModel>>> getArticles();
  Future<Either<String, List<ArticleModel>>> addArticle({
    required List<ArticleModel> list,
    required String title,
    required String body,
    required String imagePath,
  });
  Future<Either<String, List<ArticleModel>>> editArticle({
    required List<ArticleModel> list,
    required ArticleModel oldModel,
    required String title,
    required String body,
    required String imagePath,
  });
  Future<Either<String, List<ArticleModel>>> removeArticle({
    required List<ArticleModel> list,
    required ArticleModel oldModel,
  });
}
