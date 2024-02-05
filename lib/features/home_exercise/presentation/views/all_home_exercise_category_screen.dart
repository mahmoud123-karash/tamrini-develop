import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_states.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/all_home_exercise_category_content_widget.dart';

class AllHomeExerciseCategoryScreen extends StatelessWidget {
  const AllHomeExerciseCategoryScreen({
    super.key,
    required this.title,
    required this.id,
    required this.isAll,
    this.list,
  });
  final String title;
  final String id;
  final bool isAll;
  final List<Data>? list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title),
      body: BlocBuilder<HomeExerciseCubit, HomeExerciseStates>(
        builder: (context, state) {
          HomeExerciseModel? model =
              id != '' ? HomeExerciseCubit.get(context).getSection(id) : null;
          return AllHomeExercisesCategoryContentWidget(
            models: list != null ? list ?? [] : model!.data ?? [],
            id: id,
            isAll: isAll,
          );
        },
      ),
    );
  }
}
