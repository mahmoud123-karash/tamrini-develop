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

  ArticleModel getArticle(id) {
    List<ArticleModel> list =
        articles.where((element) => element.id == id).toList();
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
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetArticlesState(list));
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
        emit(ErrorGetArticlesState(message));
      },
      (list) {
        articles = list;
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessGetArticlesState(list));
      },
    );
  }

  void updateArticle({
    required ArticleModel oldModel,
    required bool isAcceped,
    required String token,
    required BuildContext context,
    required String title,
  }) async {
    var result = await articleRepo.disPendingArticle(
      list: articles,
      oldModel: oldModel,
      isAcceped: isAcceped,
      token: token,
      title: title,
    );
    result.fold(
      (message) {
        emit(ErrorGetArticlesState(message));
      },
      (list) {
        articles = list;
        showSnackBar(
          context,
          title == 'accept'
              ? S.of(context).success_accept
              : title == 'refuse'
                  ? S.of(context).success_refused
                  : S.of(context).success_banned,
        );
        emit(SucessGetArticlesState(list));
      },
    );
  }
}
