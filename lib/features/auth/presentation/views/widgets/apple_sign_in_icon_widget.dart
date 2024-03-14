import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/apple_cubit/apple_cubit.dart';
import 'package:tamrini/features/auth/presentation/manager/apple_cubit/apple_states.dart';
import 'package:tamrini/features/auth/presentation/views/complete_sign_up_screen.dart';
import 'package:tamrini/features/navBar/presentation/views/navbar_screen.dart';

class SignInWithAppleIconWidget extends StatelessWidget {
  const SignInWithAppleIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppleCubit, AppleStates>(
      listener: (context, state) {
        if (state is SuccessAppleSignInState) {
          if (!state.user.isCreated) {
            navigateTo(
              context,
              CompleteSignUpScreen(
                uid: state.user.uid,
                name: state.user.name,
                email: state.user.email,
              ),
            );
          } else {
            saveUid(state.user.uid);
            navigateToAndFinish(context, const NavBarScreen());
          }
        }
        if (state is ErrorAppleSignInState) {
          log(state.messsage);
          showToast("Failed");
        }
      },
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset(
              Assets.imagesAppleLogoS,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          AppleCubit.get(context).loginWithApple(context);
        },
      ),
    );
  }
}
