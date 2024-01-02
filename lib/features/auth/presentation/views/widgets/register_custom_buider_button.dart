import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:tamrini/features/auth/presentation/manager/register_cubit/register_states.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class RegisterCustomBuilderButton extends StatelessWidget {
  const RegisterCustomBuilderButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is ErrorRegisterState) {
          showSnackBar(context, state.message);
        }
        if (state is SuccessRegisterState) {
          Navigator.pop(context);
          showToast('Register Succeffully');
        }
      },
      builder: (context, state) {
        if (state is LoadingRegisterState) {
          return const Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return CustomButtonWidget(
            label: S.of(context).register,
            onPressed: onPressed,
          );
        }
      },
    );
  }
}
