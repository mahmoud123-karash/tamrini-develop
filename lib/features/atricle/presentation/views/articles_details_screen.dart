import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/article_details_content_widget.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/edit_article_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/ban_article_custom_button_widget.dart';

class ArticlesDetailsScreen extends StatelessWidget {
  const ArticlesDetailsScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(),
        title: Text(
          S.of(context).arDetails,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesStates>(
        builder: (context, state) {
          ArticleModel? model = ArticlesCubit.get(context).getArticle(id);
          return model == null
              ? Center(
                  child: Text(
                    S.of(context).article_removed,
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ArticleDetailsContentWidget(model: model),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            EditArticleCustomButtonWidget(model: model),
                            BanArticleCustomButtonWidget(model: model),
                          ],
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
