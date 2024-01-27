import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_articles_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_loading_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_message_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeArticlesWidgetBuilder extends StatelessWidget {
  const HomeArticlesWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesStates>(
      builder: (context, state) {
        if (state is SucessGetArticlesState) {
          List<ArticleModel> list = state.list
              .where((element) => element.isPending == false)
              .toList();
          if (list.isEmpty) {
            return Container();
          } else {
            return HomeArticlesWidget(list: list);
          }
        } else if (state is ErrorGetArticlesState) {
          return HomeMessageWidget(message: state.message);
        } else {
          return HomeLoadingWidget(
            lable: S.of(context).articles,
          );
        }
      },
    );
  }
}
