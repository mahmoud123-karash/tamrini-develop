import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';

import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/widgets/suggest_cutom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SuggestExerciseWidget extends StatelessWidget {
  const SuggestExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? 'user';
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).noExer,
            style: TextStyles.style20,
          ),
          const SizedBox(
            height: 30,
          ),
          if (userType != 'admin') const SuggestCustomButtonWidget(),
        ],
      ),
    );
  }
}
