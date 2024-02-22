import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/all_gym_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/gym_cubit/gym_cubit.dart';

class AllGymsScreen extends StatelessWidget {
  const AllGymsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      appBar: myAppBar(S.of(context).slatGym),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              GymCubit.get(context).getData(update: false);
            },
          );
        },
        child: BlocBuilder<GymCubit, GymStates>(
          builder: (context, state) {
            if (state is SucessGetGymsState) {
              return AllGymsContentWidget(models: state.list);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
