import 'package:flutter/material.dart';

import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/presentation/views/widgets/suggest_cutom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SuggestExerciseWidget extends StatelessWidget {
  const SuggestExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          S.of(context).noExer,
          style: TextStyles.style20,
        ),
        const SizedBox(
          height: 50,
        ),
        const SuggestCustomButtonWidget(),
      ],
    );
  }
}
