import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/home/presentation/views/widgets/error_get_gym_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_gym_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_loading_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeGymWidgetBuilder extends StatelessWidget {
  const HomeGymWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymCubit, GymStates>(
      builder: (context, state) {
        if (state is SucessGetGymsState) {
          if (state.list.isEmpty) {
            return Container();
          } else {
            return HomeGymWidget(list: state.list);
          }
        } else if (state is ErrorGetGymsState) {
          return ErrorGetGymWidget(
            message: state.message,
          );
        } else {
          return HomeLoadingWidget(lable: S.of(context).gym);
        }
      },
    );
  }
}
