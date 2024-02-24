import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/category_item_widget.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../atricle/presentation/views/all_articles_screen.dart';

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
            return CategoryItemWidget(
              image: Assets.imagesArticalesBanner,
              lable: S.of(context).articlesT,
              onPressed: () {
                navigateTo(context, const AllArticlesScreen());
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
