import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';
import 'package:tamrini/features/notification/presentation/views/widgets/notification_item_widget.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/user_cubit/user_states.dart';

class NotificationItemBuilderWidget extends StatelessWidget {
  const NotificationItemBuilderWidget({super.key, required this.model});
  final NotificationModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
        getIt.get<QuestionRepoImpl>(),
      )..getUser(uid: model.senderUid),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserState) {
            return NotificationItemWidget(model: model, user: state.model);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
