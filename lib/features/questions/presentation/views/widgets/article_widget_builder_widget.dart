import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/views/all_articles_screen.dart';
import 'package:tamrini/features/home/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'artilcle_container_widget.dart';

class ArticleWidgetBuilderWidget extends StatelessWidget {
  const ArticleWidgetBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesStates>(
      builder: (context, state) {
        if (state is SucessGetArticlesState) {
          if (state.list.isEmpty) {
            return Container();
          } else {
            return ArticleContainerWidget(
              image: Assets.imagesArticalesBanner,
              lable: S.of(context).articlesT,
              onPressed: () {
                navigateTo(context, AllArticlesScreen(models: state.list));
              },
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
