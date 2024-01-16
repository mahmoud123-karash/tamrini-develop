import 'package:flutter/material.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/name_text_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/social_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SocialMediaContentWidget extends StatelessWidget {
  const SocialMediaContentWidget({
    super.key,
    required this.facbookController,
    required this.instgramController,
    required this.twiterController,
  });
  final TextEditingController facbookController;
  final TextEditingController instgramController;
  final TextEditingController twiterController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameTextWidget(text: S.of(context).facebooh),
          SocialTextFiledWidget(controller: facbookController),
          const SizedBox(
            height: 10,
          ),
          NameTextWidget(text: S.of(context).instgram),
          SocialTextFiledWidget(controller: instgramController),
          const SizedBox(
            height: 10,
          ),
          NameTextWidget(text: S.of(context).twiter),
          SocialTextFiledWidget(controller: twiterController),
        ],
      ),
    );
  }
}
