import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_content_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).profile,
      ),
      body: const ProfileContentBuilderWidget(),
    );
  }
}
