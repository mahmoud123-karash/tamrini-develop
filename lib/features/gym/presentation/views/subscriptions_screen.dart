import 'package:flutter/material.dart';
import 'package:tamrini/core/models/subscription_model/subscription_model.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriber_message_builder_widget.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriptions_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key, required this.list});
  final List<SubscriptionModel> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).Subscriptions),
      body: list.isEmpty
          ? SubscriberMessageBuilderWidget(
              message: S.of(context).no_sub,
            )
          : SubscriptionsListViewWidget(list: list),
    );
  }
}
