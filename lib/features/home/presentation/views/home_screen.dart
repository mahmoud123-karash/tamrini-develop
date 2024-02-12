import 'package:flutter/material.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_articles_widget_builder.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_exercise_widget_builder.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_gym_builder_widget.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';

import 'widgets/home_product_widget_builder.dart';
import 'widgets/trainer_home_widget_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500)).then((value) {
          if (mounted) {
            TrainersCubit.get(context).getData();
            ArticlesCubit.get(context).getData();
            ExerciseCubit.get(context).getData();
            StoreCubit.get(context).getData();
            GymCubit.get(context).getData(update: false);
          }
        });
      },
      child: const SingleChildScrollView(
        child: Column(
          children: [
            TrainerHomeWidgetBuilder(),
            HomeExerciseWidgetBuilder(),
            HomeArticlesWidgetBuilder(),
            HomeProductWidgetBuilder(),
            HomeGymWidgetBuilder(),
          ],
        ),
      ),
    );
  }
}
