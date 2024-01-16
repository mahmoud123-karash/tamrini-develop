import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_states.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/loading_item_widget.dart';

import 'question_item_widget.dart';

class QuestionItemBuilderWidget extends StatelessWidget {
  const QuestionItemBuilderWidget({
    super.key,
    required this.model,
  });
  final QuestionModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
        getIt.get<QuestionRepoImpl>(),
      )..getUser(uid: model.askerUid),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserState) {
            return QuestionItemWidget(
              model: model,
              user: state.model,
            );
          } else if (state is LoadingGetUserState) {
            return const LoadingItemWidget();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
