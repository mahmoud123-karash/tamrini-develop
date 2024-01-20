import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/article_writer_widget.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_states.dart';

class ArticlWriterBuilderWidget extends StatelessWidget {
  const ArticlWriterBuilderWidget({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
        getIt.get<QuestionRepoImpl>(),
      )..getUser(uid: uid),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserState) {
            return ArticleWriterWidget(model: state.model);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}