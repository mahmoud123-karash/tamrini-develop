import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../data/models/article_model/article_model.dart';
import '../manager/article_cubit/articles_states.dart';
import 'widgets/all_articles_content_builder_widget.dart';

class AllArticlesScreen extends StatelessWidget {
  const AllArticlesScreen({
    super.key,
    this.isUserProfile = false,
    this.id,
  });
  final String? id;
  final bool isUserProfile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        isUserProfile ? S.of(context).writer_articles : S.of(context).articlesT,
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesStates>(
        builder: (context, state) {
          if (state is SucessGetArticlesState) {
            List<ArticleModel> list = state.list
                .where((element) => element.writerUid == id)
                .where((element) => element.isPending == false)
                .toList();
            return AllArticlesContentBuilderWidget(
              models: id == null ? null : list,
              isWriter: false,
              isUserProfile: isUserProfile,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
