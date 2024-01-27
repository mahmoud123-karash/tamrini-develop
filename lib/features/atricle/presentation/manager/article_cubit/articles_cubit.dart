import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/domain/repo/article_repo.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/generated/l10n.dart';

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
        emit(ErrorGetArticlesState(message));
      },
      (list) {
        articles = list;
        emit(SucessGetArticlesState(list));
      },
    );
  }

  void addArticle({
    required String title,
    required String body,
    required String imagePath,
    required BuildContext context,
  }) async {
    emit(LoadingGetArticlesState());
    var result = await articleRepo.addArticle(
      list: articles,
      title: title,
      body: body,
      imagePath: imagePath,
    );
    result.fold(
      (message) {
        emit(ErrorGetArticlesState(message));
      },
      (list) {
        articles = list;
        showSnackBar(context, S.of(context).success_add_e);
        Navigator.pop(context);
        emit(SucessGetArticlesState(list));
      },
    );
  }

  void editArticle({
    required String title,
    required String body,
    required String imagePath,
    required ArticleModel oldModel,
    required BuildContext context,
  }) async {
    emit(LoadingGetArticlesState());
    var result = await articleRepo.editArticle(
      oldModel: oldModel,
      list: articles,
      title: title,
      body: body,
      imagePath: imagePath,
    );
    result.fold(
      (message) {
        emit(ErrorGetArticlesState(message));
      },
      (list) {
        articles = list;
        showSnackBar(context, S.of(context).success_add_e);
        Navigator.pop(context);
        emit(SucessGetArticlesState(list));
      },
    );
  }
}
