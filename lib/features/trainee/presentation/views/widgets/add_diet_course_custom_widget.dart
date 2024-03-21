import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddDietCourseCustomWidget extends StatelessWidget {
  const AddDietCourseCustomWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return BlocConsumer<TraineeCubit, TraineeStates>(
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
      builder: (context, state) {
        if (state is LoadingGetTraineesState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(
            color: ThemeCubit.get(context).themeColor,
            onPressed: onPressed,
            lable: S.of(context).add,
          );
        }
      },
    );
  }
}
