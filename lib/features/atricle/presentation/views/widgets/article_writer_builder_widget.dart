import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/article_writer_widget.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';

class ArticlWriterBuilderWidget extends StatelessWidget {
  const ArticlWriterBuilderWidget(
      {super.key, required this.uid, required this.article});
  final String uid;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUser(uid: uid),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserState) {
            return ArticleWriterWidget(
              model: state.model,
              article: article,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
