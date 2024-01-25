import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/features/exercise/presentation/views/all_exercises_category_content_widget.dart';

class AllExercisesCategoryScreen extends StatelessWidget {
  const AllExercisesCategoryScreen({
    super.key,
    required this.title,
    this.list,
    this.isAll = false,
  });
  final String title;
  final List<DataModel>? list;
  final bool isAll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseStates>(
        builder: (context, state) {
          var cubit = ExerciseCubit.get(context);
          String id = CacheHelper.getData(key: 'exerciseId') ?? '';
          return AllExercisesCategoryContentWidget(
            list: isAll ? list! : cubit.getExercise(id: id).data ?? [],
            isAll: isAll,
          );
        },
      ),
    );
  }
}
