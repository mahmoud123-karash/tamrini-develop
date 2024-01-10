import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_states.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/answer_item_widget.dart';

import 'answer_loading_item_widget.dart';

class AnswerItemBuilderWidget extends StatelessWidget {
  const AnswerItemBuilderWidget({super.key, required this.model});
  final AnswerModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
        getIt.get<QuestionRepoImpl>(),
      )..getUser(uid: model.userUid),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserState) {
            return AnswerItemWidgt(
              model: model,
              image: state.model.image,
              name: state.model.name,
              type: getQuestionUserType(state.model),
            );
          } else if (state is ErrorGetUserState) {
            return Container();
          } else {
            return const AnswerLoadingItemWidgt();
          }
        },
      ),
    );
  }
}
