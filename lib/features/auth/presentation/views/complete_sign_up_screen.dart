import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/auth/data/repo/register_repo_impl.dart';
import 'package:tamrini/features/auth/presentation/manager/complete_cubit/complete_cubit.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/complete_context_widget.dart';

class CompleteSignUpScreen extends StatelessWidget {
  const CompleteSignUpScreen({
    super.key,
    required this.uid,
    required this.name,
    required this.email,
  });
  final String uid, name, email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteCubit(
        RegisterRepoImpl(),
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesLogin1),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: CompleteContentWidget(
                name: name,
                email: email,
                uid: uid,
              ),
            ),
          )
        ],
      ),
    );
  }
}
