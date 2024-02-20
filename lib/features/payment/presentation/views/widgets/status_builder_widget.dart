import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_states.dart';
import 'package:tamrini/generated/l10n.dart';

class StatusBuilderWidget extends StatefulWidget {
  const StatusBuilderWidget({
    super.key,
    required this.trasactionId,
    required this.id,
    required this.amount,
    required this.onSuccess,
  });
  final String trasactionId, id;
  final num amount;
  final VoidCallback onSuccess;

  @override
  State<StatusBuilderWidget> createState() => _StatusBuilderWidgetState();
}

class _StatusBuilderWidgetState extends State<StatusBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatusCubit, StatusStates>(
      listener: (context, state) {
        if (state is PendingStatusState) {
          showSnackBar(context, S.of(context).pending_hint_payment);
        }
        if (state is FailedStatusState) {
          showSnackBar(context, S.of(context).please_try_again);
        }
      },
      builder: (context, state) {
        if (state is FailedStatusState) {
          return customButton(
            onPressed: () {
              Navigator.pop(context);
            },
            lable: S.of(context).back,
          );
        } else if (state is LoadingGetStatusState) {
          return const CircularProgressIndicator();
        } else if (state is SucessStatusState) {
          return addCustomButton(
            color: Colors.amber,
            icon: Icons.done,
            onPressed: widget.onSuccess,
            lable: S.of(context).payment_success_button,
          );
        } else {
          return customButton(
            onPressed: () {
              StatusCubit.get(context).getStatus(id: widget.trasactionId);
            },
            lable: S.of(context).next,
          );
        }
      },
    );
  }
}
