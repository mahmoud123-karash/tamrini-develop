import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/request_list_view_builder_widget.dart';

class ProfitsRequestScreen extends StatelessWidget {
  const ProfitsRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).profits_request),
      body: const RequestListViewBuilderWidget(),
    );
  }
}
