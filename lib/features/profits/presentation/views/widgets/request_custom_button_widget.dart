import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profits/presentation/manager/request_cubit/request_cubit.dart';
import 'package:tamrini/features/profits/presentation/manager/request_cubit/request_states.dart';
import 'package:tamrini/generated/l10n.dart';

class RequestCustomButtonWidget extends StatelessWidget {
  const RequestCustomButtonWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestCubit, RequestStates>(
      listener: (context, state) {
        if (state is ErrorRequestState) {
          showSnackBar(context, state.message);
        }
        if (state is SuccessRequestState) {
          RequestCubit.get(context).isRequest = true;
        }
      },
      builder: (context, state) {
        if (state is LoadingRequestState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(
            onPressed: onPressed,
            lable: S.of(context).request_profits,
          );
        }
      },
    );
  }
}
