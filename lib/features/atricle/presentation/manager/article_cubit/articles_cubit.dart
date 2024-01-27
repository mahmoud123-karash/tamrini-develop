import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/atricle/domain/repo/article_repo.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';

import '../../../data/models/article_model/article_model.dart';

class ArticlesCubit extends Cubit<ArticlesStates> {
  ArticlesCubit(this.articleRepo) : super(InitialArticlesState());

  static ArticlesCubit get(context) => BlocProvider.of(context);

  final ArticleRepo articleRepo;
  List<ArticleModel> articles = [];

  List<ArticleModel> getUserArticles(uid) {
    List<ArticleModel> list =
        articles.where((element) => element.writerUid == uid).toList();
    return list;
  }

  ArticleModel getArticle(uid) {
    List<ArticleModel> list =
        articles.where((element) => element.writerUid == uid).toList();
    return list.first;
  }

  void getData() async {
    emit(LoadingGetArticlesState());
    var result = await articleRepo.getArticles();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetArticlesState(message));
      },
      (list) {
        articles = list;
        emit(SucessGetArticlesState(list));
      },
    );
  }
}
