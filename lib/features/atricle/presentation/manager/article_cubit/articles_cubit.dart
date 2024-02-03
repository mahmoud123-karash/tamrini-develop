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
    List<ArticleModel> list = articles
        .where((element) => element.writerUid == uid)
        .where((element) => element.isPending == false)
        .toList();
    return list;
  }

  ArticleModel? getArticle(id) {
    List<ArticleModel> list =
        articles.where((element) => element.id == id).toList();
    if (list.isEmpty) {
      return null;
    }
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
        List<ArticleModel> models = clearPendingArticles(list);
        articles = list;
        emit(SucessGetArticlesState(models));
      },
    );
  }

  List<ArticleModel> clearPendingArticles(List<ArticleModel> list) {
    List<ArticleModel> models = [];
    for (var element in list) {
      if (element.isPending == false) {
        models.add(element);
      }
    }
    return models;
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
        List<ArticleModel> models = clearPendingArticles(list);
        articles = list;
        showSnackBar(context, S.of(context).success_add_a);
        Navigator.pop(context);
        emit(SucessGetArticlesState(models));
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
        List<ArticleModel> models = clearPendingArticles(list);
        articles = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetArticlesState(models));
      },
    );
  }

  void removeArticle({
    required ArticleModel oldModel,
    required BuildContext context,
  }) async {
    var result = await articleRepo.removeArticle(
      oldModel: oldModel,
      list: articles,
    );
    result.fold(
      (message) {
        getData();
        emit(ErrorGetArticlesState(message));
      },
      (list) {
        List<ArticleModel> models = clearPendingArticles(list);
        articles = list;
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessGetArticlesState(models));
      },
    );
  }

  void banArticle({
    required bool isPending,
    required String articleId,
    required String writerUid,
    required BuildContext context,
  }) async {
    var result = await articleRepo.banArticle(
      isPending: isPending,
      articleId: articleId,
      writerUid: writerUid,
    );
    result.fold(
      (message) {
        getData();
        emit(ErrorGetArticlesState(message));
      },
      (list) {
        List<ArticleModel> models = clearPendingArticles(list);
        articles = list;
        showSnackBar(
          context,
          isPending ? S.of(context).ban_succes : S.of(context).no_ban_scucess,
        );
        emit(SucessGetArticlesState(models));
      },
    );
  }
}
