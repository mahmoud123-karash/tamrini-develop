import 'package:flutter/material.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/subscriber_list_view_builder_widget.dart';

class GymSubcribersScreen extends StatefulWidget {
  const GymSubcribersScreen({super.key, required this.gymId});
  final String gymId;

  @override
  State<GymSubcribersScreen> createState() => _GymSubcribersScreenState();
}

class _GymSubcribersScreenState extends State<GymSubcribersScreen> {
  @override
  void initState() {
    SubscriberCubit.get(context).getSubscribers(gymId: widget.gymId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).subcribers),
      body: const SubscriberListViewBuilderWidget(),
    );
  }
}
