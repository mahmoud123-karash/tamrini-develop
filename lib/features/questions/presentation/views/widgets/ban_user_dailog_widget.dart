import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/questions/domain/use_cases/ban_user_case.dart';
import 'package:tamrini/features/questions/presentation/manager/ban_cubit/ban_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class BanUserDailogWidget extends StatelessWidget {
  const BanUserDailogWidget({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BanCubit(
        getIt.get<BanUserUseCase>(),
      ),
      child: Container(
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
                          BanCubit.get(context).banUser(
                            uid: uid,
                            isBanned: !state.model.isBanned,
                            message: state.model.isBanned
                                ? S.of(context).no_ban_scucess
                                : S.of(context).ban_succes,
                          );
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
      ),
    );
  }
}
