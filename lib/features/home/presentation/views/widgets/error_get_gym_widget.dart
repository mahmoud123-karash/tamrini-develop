import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/home/presentation/views/widgets/update_location_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ErrorGetGymWidget extends StatelessWidget {
  const ErrorGetGymWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            message,
            style: TextStyles.style17,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        UpdateLocationCustomButtonWidget(
          lable: S.of(context).tryAgain,
          onPressed: () {
            GymCubit.get(context).getData(update: false);
          },
        )
      ],
    );
  }
}
