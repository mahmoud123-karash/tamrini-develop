import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/widgets/user_builder_widget.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_states.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/home_exercise_details_content_widget.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/no_exerxise_text_widget.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/edit_home_exercise_custom_widget.dart';

class HomeExerciseBodyWidget extends StatelessWidget {
  const HomeExerciseBodyWidget(
      {super.key, required this.id, required this.isAll, this.player});
  final String id;
  final bool isAll;
  final Widget? player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BlocBuilder<HomeExerciseCubit, HomeExerciseStates>(
          builder: (context, state) {
            Data? model = HomeExerciseCubit.get(context).getExercise(id);
            return model == null
                ? const NoExerciseTextWidget()
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: HomeExerciseDetailsContentWidget(
                          model: model,
                          player: player,
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Divider(),
                              UserBuilderWidget(uid: model.writerUid),
                              const SizedBox(
                                height: 10,
                              ),
                              if (!isAll)
                                EditHomeExerciseCustomButtonWidget(
                                  model: model,
                                ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
