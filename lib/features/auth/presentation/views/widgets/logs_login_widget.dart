import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/auth/domain/use_cases/apple_sign_in_use_case.dart';
import 'package:tamrini/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:tamrini/features/auth/presentation/manager/apple_cubit/apple_cubit.dart';
import 'package:tamrini/features/auth/presentation/manager/google_cubit/google_cubit.dart';
import 'apple_sign_in_icon_widget.dart';
import 'sign_in_with_google_icon_widget.dart';

class LogsLoginWidget extends StatelessWidget {
  const LogsLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocProvider(
            create: (context) => GoogleCubit(
              getIt.get<GoogleSignInUseCase>(),
            ),
            child: const SignInWithGoogleIconWidget(),
          ),
          if (Platform.isIOS)
            const SizedBox(
              width: 15,
            ),
          if (Platform.isIOS)
            BlocProvider(
              create: (context) => AppleCubit(
                getIt.get<AppleSignInUseCase>(),
              ),
              child: const SignInWithAppleIconWidget(),
            ),
        ],
      ),
    );
  }
}
