import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/title_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TarinerDescriptionWidget extends StatelessWidget {
  const TarinerDescriptionWidget({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        TitleTextWidget(lable: S.of(context).achevement),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            style: TextStyles.style14,
          ),
        ),
      ],
    );
  }
}
