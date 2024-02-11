import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../manager/trainer_cubit/trainers_cubit.dart';
import '../../manager/trainer_cubit/trainers_states.dart';

class BanCustomBuilderWidget extends StatelessWidget {
  const BanCustomBuilderWidget({super.key, required this.trainer});
  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainersCubit, TrainersStates>(
      builder: (context, state) {
        if (state is LoadingGetTrainersState) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: customButton(
              color: Colors.red,
              onPressed: () {
                AwesomeDialog(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  showCloseIcon: true,
                  titleTextStyle: TextStyles.style17.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.bottomSlide,
                  title: trainer.user!.name,
                  desc: !trainer.isBanned
                      ? S.of(context).ban_trainer_question
                      : S.of(context).no_ban_trainer_question,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    TrainersCubit.get(context).banTrainer(
                      isBanned: !trainer.isBanned,
                      trainerId: trainer.uid,
                    );
                  },
                ).show();
              },
              lable:
                  trainer.isBanned ? S.of(context).no_ban : S.of(context).ban,
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is ErrorGetTrainersState) {
          TrainersCubit.get(context).getData();
          showSnackBar(context, state.message);
        }

        if (state is SucessGetTrainersState) {
          showSnackBar(
            context,
            trainer.isBanned
                ? S.of(context).no_ban_scucess
                : S.of(context).ban_succes,
          );
        }
      },
    );
  }
}
