import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/article_details_content_widget.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/edit_article_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ArticlesDetailsScreen extends StatelessWidget {
  const ArticlesDetailsScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).arDetails),
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
                        child: EditArticleCustomButtonWidget(model: model),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
