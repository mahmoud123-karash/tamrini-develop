import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:tamrini/features/auth/presentation/manager/login_cubit/login_states.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/custom_button_widget.dart';
import 'package:tamrini/features/nav_bar/presentation/views/navbar_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class LoginCustomBuilderButton extends StatelessWidget {
  const LoginCustomBuilderButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is SuccessLoginState) {
          saveUid(state.uid);
          navigateToAndFinish(context, const NavBarScreen());
        }
        if (state is ErrorLoginState) {
          if (state.messsage == 'Not') {
            showSnackBar(context, S.of(context).emailverify);
          } else {
            showSnackBar(context, state.messsage);
          }
        }
      },
      builder: (context, state) {
        if (state is LoadingLoginState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return CustomButtonWidget(
            label: S.of(context).login,
            onPressed: onPressed,
          );
        }
      },
    );
  }
}
