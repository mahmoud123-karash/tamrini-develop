import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/all_articles_content_builder_widget.dart';

class WriterArticlesScreen extends StatelessWidget {
  const WriterArticlesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).your_articles,
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesStates>(
        builder: (context, state) {
          if (state is SucessGetArticlesState) {
            String uid = CacheHelper.getData(key: 'uid');
            List<ArticleModel> models = state.list
                .where((element) => element.isPending == false)
                .where((element) => element.writerUid == uid)
                .toList();
            return AllArticlesContentBuilderWidget(
              models: models,
              isWriter: true,
              pendingLength: state.list
                  .where((element) => element.isPending == true)
                  .where((element) => element.writerUid == uid)
                  .length,
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
