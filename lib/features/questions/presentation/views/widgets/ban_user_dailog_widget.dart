import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

class BanUserDailogWidget extends StatelessWidget {
  const BanUserDailogWidget({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 15,
            ),
            BlocProvider(
              create: (context) => UserCubit()..getUser(uid: uid),
              child: BlocBuilder<UserCubit, UserStates>(
                builder: (context, state) {
                  if (state is SucessGetUserState) {
                    return ListTile(
                      tileColor: Colors.red.withOpacity(0.1),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        UserCubit.get(context).banUser(
                          uid: uid,
                          isBanned: !state.model.isBanned,
                        );
                        if (state.model.isBanned) {
                          showToast(S.of(context).no_ban_user_success);
                        } else {
                          showToast(S.of(context).ban_user_success);
                        }
                      },
                      title: Text(
                        state.model.isBanned
                            ? S.of(context).no_ban
                            : S.of(context).ban,
                      ),
                      leading: const Icon(
                        Icons.remove_circle,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
