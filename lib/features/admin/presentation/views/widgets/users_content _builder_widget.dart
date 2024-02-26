import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/admin/presentation/manager/user_cubit/users_cubit.dart';
import 'package:tamrini/features/admin/presentation/manager/user_cubit/users_states.dart';
import 'package:tamrini/features/admin/presentation/views/widgets/users_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class UsersContentBuilderWidget extends StatefulWidget {
  const UsersContentBuilderWidget({super.key, required this.userType});
  final String userType;

  @override
  State<UsersContentBuilderWidget> createState() =>
      _UsersContentBuilderWidgetState();
}

class _UsersContentBuilderWidgetState extends State<UsersContentBuilderWidget> {
  @override
  void initState() {
    if (mounted) {
      UsersCubit.get(context).getUsers(userType: widget.userType);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersStates>(
      builder: (context, state) {
        if (state is SucessGetUsersState) {
          if (state.list.isEmpty) {
            return MessageWidget(message: S.of(context).no_users);
          }
          return UsersContentWidget(
            list: state.list,
          );
        } else if (state is ErrorGetUsersState) {
          return MessageWidget(
            message: state.message,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
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
