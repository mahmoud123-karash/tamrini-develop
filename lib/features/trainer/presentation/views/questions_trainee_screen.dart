import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/add_question_dialog_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/trainer_cubit/trainers_states.dart';
import 'widgets/question_trainee_item_widget.dart';
import 'widgets/questions_trainees_hint_container_widget.dart';

class QuestionsTraineeScreen extends StatelessWidget {
  const QuestionsTraineeScreen({super.key, required this.trainerId});
  final String trainerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).questions_trainee),
      body: BlocBuilder<TrainersCubit, TrainersStates>(
        builder: (context, state) {
          TrainerModel? model =
              TrainersCubit.get(context).getTrainer(uid: trainerId);
          List<String> questions = model == null ? [] : model.questionsTrainees;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              children: [
                if (questions.isEmpty)
                  const QuestionsTraineesHintContainerWidget(),
                const SizedBox(
                  height: 5,
                ),
                addCustomButton(
                  fontSize: 15,
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) =>
                          AddQuestionDailogWidget(model: model!),
                    );
                  },
                  lable: S.of(context).add_new_question,
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: questions.isEmpty
                      ? Center(
                          child: Text(
                            S.of(context).no_results,
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return QuestionTraineeItemWidget(
                              index: index,
                              question: questions[index],
                              model: model!,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: questions.length,
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
