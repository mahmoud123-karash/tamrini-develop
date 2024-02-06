import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/gym_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class BannedGymsScreen extends StatelessWidget {
  const BannedGymsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidth = mediaQuery.size.width;
    return Scaffold(
      appBar: myAppBar(S.of(context).store_banned),
      body: BlocBuilder<GymCubit, GymStates>(
        builder: (context, state) {
          List<GymModel> list = GymCubit.get(context)
              .gyms
              .where((element) => element.isBanned == true)
              .toList();

          return list.isEmpty
              ? Center(
                  child: Text(S.of(context).no_results),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GymItemWidget(
                        model: list[index],
                        width: getWidth,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: list.length,
                  ),
                );
        },
      ),
    );
  }
}
