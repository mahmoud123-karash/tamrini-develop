import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/promotion/presentation/views/widgets/upgarde_account_content_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class UpgradeAcountScreen extends StatelessWidget {
  const UpgradeAcountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).update_your_account),
      body: const UpgradeAccountContentBuilderWidget(),
    );
  }
}
