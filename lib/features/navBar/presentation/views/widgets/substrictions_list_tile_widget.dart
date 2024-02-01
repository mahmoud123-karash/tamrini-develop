import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/subscriptions_screen.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SubstrictionsListTileWidget extends StatelessWidget {
  const SubstrictionsListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getSubscriptions(),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserSubState) {
            return DrawerListTileWidget(
              onPressed: () {
                navigateTo(context, SubscriptionsScreen(list: state.list));
              },
              icon: Icons.subscriptions_outlined,
              lable: S.of(context).Subscriptions,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
