import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/article_model/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
}

class ArticleRemoteDataSourceImpl extends ArticleRemoteDataSource {
  @override
  Future<List<ArticleModel>> getArticles() async {
    List<ArticleModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('articles')
        .doc('data')
        .collection('articles')
        .orderBy('date', descending: true)
        .get();

    for (var element in result.docs) {
      ArticleModel model = ArticleModel.fromJson(element.data(), element.id);
      list.add(model);
    }
    return list;
  }
}
