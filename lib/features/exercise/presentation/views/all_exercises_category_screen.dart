import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/all_exercises_category_content_widget.dart';

class AllExercisesCategoryScreen extends StatelessWidget {
  const AllExercisesCategoryScreen({
    super.key,
    required this.title,
    this.list,
    this.isAll = false,
    required this.isCourse,
  });
  final String title;
  final List<DataModel>? list;
  final bool isAll;
  final bool isCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title),
      bottomNavigationBar: const BannerAdWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              ExerciseCubit.get(context).getData();
            },
          );
        },
        child: BlocBuilder<ExerciseCubit, ExerciseStates>(
          builder: (context, state) {
            var cubit = ExerciseCubit.get(context);
            String id = CacheHelper.getData(key: 'exerciseId') ?? '';
            return AllExercisesCategoryContentWidget(
              list: isAll ? list! : cubit.getExercise(id: id).data ?? [],
              isAll: isAll,
              isCourse: isCourse,
            );
          },
        ),
      ),
    );
  }
}
