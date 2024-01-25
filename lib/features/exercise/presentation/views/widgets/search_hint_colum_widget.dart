import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

import '../../../../../generated/l10n.dart';
import '../../../../suggest_exercise/presentation/views/widgets/suggest_cutom_button_widget.dart';

class SearchHintColumWidget extends StatelessWidget {
  const SearchHintColumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).noExer,
          style: TextStyles.style20,
        ),
        const SizedBox(
          height: 20,
        ),
        const SuggestCustomButtonWidget(),
      ],
    );
  }
}
