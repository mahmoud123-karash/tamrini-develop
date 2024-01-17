import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/domain/repo/home_repo.dart';
import 'package:tamrini/features/home/presentation/manager/article_cubit/articles_states.dart';

import '../../../data/models/article_model/article_model.dart';

class ArticlesCubit extends Cubit<ArticlesStates> {
  ArticlesCubit(this.homeRepo) : super(InitialArticlesState());

  static ArticlesCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;
  List<ArticleModel> articles = [];

  List<ArticleModel> getArticles(uid) {
    List<ArticleModel> list =
        articles.where((element) => element.writerUid == uid).toList();
    return list;
  }

  void getData() async {
    emit(LoadingGetArticlesState());
    var result = await homeRepo.getArticles();
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
