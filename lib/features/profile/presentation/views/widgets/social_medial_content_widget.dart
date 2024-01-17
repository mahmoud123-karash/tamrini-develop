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
    required this.formKey,
    required this.autovalidateMode,
  });
  final TextEditingController facbookController;
  final TextEditingController instgramController;
  final TextEditingController twiterController;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NameTextWidget(text: S.of(context).facebooh),
            SocialTextFiledWidget(
              prefix: 'facebook.com',
              controller: facbookController,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 10,
            ),
            NameTextWidget(text: S.of(context).instgram),
            SocialTextFiledWidget(
              prefix: 'instagram.com',
              controller: instgramController,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 10,
            ),
            NameTextWidget(text: S.of(context).twiter),
            SocialTextFiledWidget(
              prefix: 'twitter.com',
              controller: twiterController,
              autovalidateMode: autovalidateMode,
            ),
          ],
        ),
      ),
    );
  }
}
