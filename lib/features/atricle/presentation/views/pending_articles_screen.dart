import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/pending_list_view_builder_widget.dart';

class PendingArticlesScreen extends StatelessWidget {
  const PendingArticlesScreen({super.key, required this.isWriter});
  final bool isWriter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).penging_articles),
      body: BlocBuilder<ArticlesCubit, ArticlesStates>(
        builder: (context, state) {
          if (state is SucessGetArticlesState) {
            String uid = CacheHelper.getData(key: 'uid');
            List<ArticleModel> pendingList = state.list
                .where((element) => element.isPending == true)
                .toList();
            List<ArticleModel> pendingWriterList = state.list
                .where((element) => element.isPending == true)
                .where((element) => element.writerUid == uid)
                .toList();
            if (pendingList.isEmpty) {
              return messageBuilder(
                message: S.of(context).no_pending_articles,
              );
            }
            return PendingListViewBuilderWidget(
              list: isWriter ? pendingWriterList : pendingList,
            );
          } else if (state is ErrorGetArticlesState) {
            return messageBuilder(message: state.message);
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
