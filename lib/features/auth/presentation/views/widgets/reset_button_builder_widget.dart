import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/reset_cubit/reset_cubit.dart';
import 'package:tamrini/features/auth/presentation/manager/reset_cubit/reset_states.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/reset_custom_button_widget.dart';

class ResetButtonBuilderWidget extends StatelessWidget {
  const ResetButtonBuilderWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetCubit, ResetStates>(
      listener: (context, state) {
        if (state is ErrorResetState) {
          showSnackBar(context, state.error);
        }
        if (state is SuccessResetState) {
          Navigator.pop(context);
          showToast('Check your email');
        }
      },
      builder: (context, state) {
        if (state is LoadingResetState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return ResetCustomButtonWidget(onPressed: onPressed);
        }
      },
    );
  }
}
