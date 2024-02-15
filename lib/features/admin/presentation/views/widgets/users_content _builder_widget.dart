import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/admin/presentation/manager/user_cubit/users_cubit.dart';
import 'package:tamrini/features/admin/presentation/manager/user_cubit/users_states.dart';
import 'package:tamrini/features/admin/presentation/views/widgets/users_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class UsersContentBuilderWidget extends StatelessWidget {
  const UsersContentBuilderWidget({super.key, required this.userType});
  final String userType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersStates>(
      builder: (context, state) {
        if (state is SucessGetUsersState) {
          List<UserModel> finalList =
              state.list.where((element) => element.role == userType).toList();

          if (finalList.isEmpty && userType != '') {
            return MessageWidget(message: S.of(context).no_users);
          }
          return UsersContentWidget(
              list: userType == '' ? state.list : finalList);
        } else if (state is ErrorGetUsersState) {
          return MessageWidget(
            message: state.message,
          );
        } else {
          return loadingWidget();
        }
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }
}
