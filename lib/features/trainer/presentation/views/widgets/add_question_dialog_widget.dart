import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddQuestionDailogWidget extends StatefulWidget {
  const AddQuestionDailogWidget({super.key, required this.model});
  final TrainerModel model;

  @override
  State<AddQuestionDailogWidget> createState() =>
      _AddQuestionDailogWidgetState();
}

class _AddQuestionDailogWidgetState extends State<AddQuestionDailogWidget> {
  TextEditingController questionController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isDark = CacheHelper.getData(key: 'isdark') ?? false;
    return AlertDialog(
      title: Text(
        S.of(context).add_new_question,
        style: TextStyles.style14.copyWith(
          color: appColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Form(
        key: formKey,
        child: addTextField(
          lable: S.of(context).question,
          controller: questionController,
          context: context,
          autovalidateMode: autovalidateMode,
        ),
      ),
      actions: [
        BlocConsumer<TrainersCubit, TrainersStates>(
          listener: (context, state) {
            if (state is ErrorGetTrainersState) {
              showToast(state.message);
              TrainersCubit.get(context).getData();
            }
            if (state is SucessGetTrainersState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is LoadingGetTrainersState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TrainersCubit.get(context).addNewQuestion(
                      trainer: widget.model,
                      question: questionController.text,
                      message: S.of(context).success_add_a,
                    );
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                child: Text(
                  S.of(context).add,
                  style: TextStyles.style13.copyWith(
                    color: isDark ? whiteColor : blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        ),
        BlocBuilder<TrainersCubit, TrainersStates>(
          builder: (context, state) {
            if (state is LoadingGetTrainersState) {
              return Container();
            } else {
              return TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  S.of(context).cancel,
                  style: TextStyles.style13.copyWith(
                    color: isDark ? whiteColor : blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
