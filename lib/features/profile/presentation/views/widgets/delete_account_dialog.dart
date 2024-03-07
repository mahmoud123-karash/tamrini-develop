import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/auth/data/repo/login_repo_impl.dart';
import 'package:tamrini/features/auth/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:tamrini/features/auth/presentation/manager/delete_account_cubit/delete_account_states.dart';
import 'package:tamrini/features/auth/presentation/views/login_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class DeleteAccountDialogWidget extends StatelessWidget {
  const DeleteAccountDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccountCubit(
        getIt.get<LoginRepoImpl>(),
      ),
      child: AlertDialog(
        title: Text(S.of(context).delete_account_question),
        content: Text(S.of(context).delete_account_hint),
        actions: [
          BlocBuilder<DeleteAccountCubit, DeleteAccountStates>(
            builder: (context, state) {
              if (state is LoadingDeleteAccountState) {
                return Container();
              } else {
                return TextButton(
                  child: Text(S.of(context).cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              }
            },
          ),
          BlocConsumer<DeleteAccountCubit, DeleteAccountStates>(
            listener: (context, state) {
              if (state is ErrorDeleteAccountState) {
                showSnackBar(context, state.messsage);
              }
              if (state is ReAuthAccountState) {
                Navigator.pop(context);
                showSnackBar(context, S.of(context).re_auth_account);
              }
              if (state is SuccessDeleteAccountState) {
                logOut(context);
                navigateToAndFinish(context, const LoginScreen());
              }
            },
            builder: (context, state) {
              if (state is LoadingDeleteAccountState) {
                return const CircularProgressIndicator();
              } else {
                return TextButton(
                  child: Text(
                    S.of(context).delete,
                    style: TextStyles.style14.copyWith(color: Colors.red),
                  ),
                  onPressed: () {
                    DeleteAccountCubit.get(context).deleteAccount();
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
