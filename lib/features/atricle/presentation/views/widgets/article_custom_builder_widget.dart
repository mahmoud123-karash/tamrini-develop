import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';

class ArticleCustombuilderWidget extends StatelessWidget {
  const ArticleCustombuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticlesCubit, ArticlesStates>(
      listener: (context, state) {
        if (state is ErrorGetArticlesState) {
          showSnackBar(context, state.message);
          ArticlesCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        if (state is LoadingGetArticlesState) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: customButton(
              onPressed: onPressed,
              lable: lable,
            ),
          );
        }
      },
    );
  }
}
