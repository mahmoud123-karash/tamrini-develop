import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/subscribers_list_view_widget.dart';

class GymSubcribersScreen extends StatelessWidget {
  const GymSubcribersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).subcribers),
      body: SubscriberListViewWidget(),
    );
  }
}
