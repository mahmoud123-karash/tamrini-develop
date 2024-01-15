import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/complete_cubit/complete_cubit.dart';
import 'package:tamrini/features/auth/presentation/manager/complete_cubit/complete_states.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/custom_button_widget.dart';
import 'package:tamrini/features/navBar/presentation/views/navabar_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class CompleteCustomBuilderWidget extends StatelessWidget {
  const CompleteCustomBuilderWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteCubit, CompleteStates>(
      listener: (context, state) {
        if (state is ErrorCompleteState) {
          showSnackBar(context, state.messsage);
        }
        if (state is SuccessCompleteState) {
          saveUid(state.uid);
          saveUserType('user');
          navigateToAndFinish(context, const NavBarScreen());
        }
      },
      builder: (context, state) {
        if (state is LoadingCompleteState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return CustomButtonWidget(
            label: S.of(context).complete,
            onPressed: onPressed,
          );
        }
      },
    );
  }
}
