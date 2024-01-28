import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/article_model/article_model.dart';
import 'all_articles_content_widget.dart';

class AllArticlesContentBuilderWidget extends StatelessWidget {
  const AllArticlesContentBuilderWidget({
    super.key,
    this.models,
    required this.isWriter,
    this.pendingLength,
  });
  final List<ArticleModel>? models;
  final bool isWriter;
  final int? pendingLength;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesStates>(
      builder: (context, state) {
        if (state is SucessGetArticlesState) {
          List<ArticleModel> list = state.list
              .where((element) => element.isPending == false)
              .toList();
          if (list.isEmpty) {
            return messageBuilder(
              message: S.of(context).noArticles,
            );
          }
          return AllArticleContentWidget(
            list: models != null ? models! : list,
            isWriter: isWriter,
            length: pendingLength != null
                ? pendingLength!
                : state.list.length - list.length,
          );
        } else if (state is ErrorGetArticlesState) {
          return messageBuilder(message: state.message);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
