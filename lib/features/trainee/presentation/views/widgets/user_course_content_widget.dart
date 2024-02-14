import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/views/courses_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/diet_course_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/follow_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/trainee_supplement_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/trainee_list_tile_widget.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/trainer_widget.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'waring_end_sub_container_widget.dart';

class UserCourseContentWidget extends StatelessWidget {
  const UserCourseContentWidget({super.key, required this.traineeModel});
  final TraineeModel traineeModel;

  @override
  Widget build(BuildContext context) {
    DateTime endDate =
        traineeModel.dateOfSubscription.toDate().add(const Duration(days: 30));
    bool isEnd = endDate.isBefore(DateTime.now());
    String trainerId = CacheHelper.getData(key: 'trainerId');

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isEnd)
            WarningEndSubContainerWidget(
              message: S.of(context).sub_end_waring_trainee,
            ),
          BlocBuilder<TrainersCubit, TrainersStates>(
            builder: (context, state) {
              TrainerModel? model =
                  TrainersCubit.get(context).getTrainer(uid: trainerId);
              if (state is SucessGetTrainersState) {
                return model == null
                    ? Container()
                    : TrainerCourseWidget(
                        model: model,
                        isEnd: isEnd,
                        chatId: traineeModel.chatId,
                      );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Intl.getCurrentLocale() == 'ar'
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                S.of(context).training_course,
                style: TextStyles.style16Bold.copyWith(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<TrainersCubit, TrainersStates>(
            builder: (context, state) {
              if (state is SucessGetTrainersState) {
                TrainerModel? model =
                    TrainersCubit.get(context).getTrainer(uid: trainerId);
                return model == null
                    ? Container()
                    : TraineeListTileWidget(
                        lable: S.of(context).follow_and_data,
                        icon: Icons.follow_the_signs_rounded,
                        onTap: () {
                          if (!isEnd) {
                            navigateTo(
                              context,
                              FollowScreen(
                                model: traineeModel,
                                questions: model.questionsTrainees,
                              ),
                            );
                          }
                        },
                      );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TraineeListTileWidget(
            lable: S.of(context).courses,
            icon: Icons.golf_course_outlined,
            onTap: () {
              if (!isEnd) {
                navigateTo(
                  context,
                  CourcesScreen(
                    traineeId: '',
                    list: traineeModel.courses,
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TraineeListTileWidget(
            lable: S.of(context).diet,
            icon: Icons.fastfood_outlined,
            onTap: () {
              if (!isEnd) {
                navigateTo(
                  context,
                  DietCourseScreen(
                    traineeId: '',
                    list: traineeModel.food,
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TraineeListTileWidget(
            lable: S.of(context).nuttritions,
            icon: Icons.local_drink_outlined,
            onTap: () {
              if (!isEnd) {
                navigateTo(
                  context,
                  TraineeSupplementsScreen(
                      traineeId: '', supplements: traineeModel.supplements),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
