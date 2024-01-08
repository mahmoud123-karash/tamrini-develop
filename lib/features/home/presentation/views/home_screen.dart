import 'package:flutter/material.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_articles_widget_builder.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_exercise_widget_builder.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_gym_builder_widget.dart';

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
    return const SingleChildScrollView(
      child: Column(
        children: [
          TrainerHomeWidgetBuilder(),
          HomeExerciseWidgetBuilder(),
          HomeArticlesWidgetBuilder(),
          HomeProductWidgetBuilder(),
          HomeGymWidgetBuilder(),
        ],
      ),
    );
  }
}
