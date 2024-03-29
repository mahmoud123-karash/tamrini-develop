import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
import 'package:tamrini/core/widgets/writer_row_widget.dart';

class UserBuilderWidget extends StatelessWidget {
  const UserBuilderWidget({
    super.key,
    required this.uid,
  });
  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUser(uid: uid),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserState) {
            return WriterRowWidget(
              model: state.model,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
