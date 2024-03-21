import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../manager/theme_cubit/theme_cubit.dart';

class CourseCustomButtonBuilderWidget extends StatelessWidget {
  const CourseCustomButtonBuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return BlocConsumer<TraineeCubit, TraineeStates>(
      builder: (context, state) {
        if (state is LoadingGetTraineesState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(
            onPressed: onPressed,
            lable: lable,
            color: ThemeCubit.get(context).themeColor,
          );
        }
      },
      listener: (context, state) {
        if (state is ErrorGetTraineesState) {
          showSnackBar(context, state.message);
          TraineeCubit.get(context).getData(trainerId: uid);
        }

        if (state is SucessGetTraineesState) {
          showSnackBar(context, S.of(context).success_add_a);
          Navigator.pop(context);
        }
      },
    );
  }
}
