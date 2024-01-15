import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/auth/data/repo/login_repo_impl.dart';
import 'package:tamrini/features/auth/presentation/manager/login_cubit/login_cubit.dart';

import 'widgets/login_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(Assets.imagesLogin1), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        getIt.get<LoginRepoImpl>(),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesLogin1),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: LoginContent(),
            ),
          ),
        ],
      ),
    );
  }
}
