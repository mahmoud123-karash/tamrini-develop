import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/all_gym_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/gym_cubit/gym_cubit.dart';

class AllGymsScreen extends StatelessWidget {
  const AllGymsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).slatGym),
      body: BlocBuilder<GymCubit, GymStates>(
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
    );
  }
}
