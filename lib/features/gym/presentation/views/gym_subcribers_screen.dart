import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/repo/gym_repo_impl.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/subscriber_list_view_builder_widget.dart';

class GymSubcribersScreen extends StatelessWidget {
  const GymSubcribersScreen({super.key, required this.gymId});
  final String gymId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriberCubit(
        getIt.get<GymRepoImpl>(),
      )..getSubscribers(gymId: gymId),
      child: Scaffold(
        appBar: myAppBar(S.of(context).subcribers),
        body: const SubscriberListViewBuilderWidget(),
      ),
    );
  }
}
