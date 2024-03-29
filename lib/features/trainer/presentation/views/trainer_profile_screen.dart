import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/features/trainer/presentation/views/edit_trainer_screen.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/sub_button_with_trainer_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_content_widget.dart';

import 'package:tamrini/generated/l10n.dart';

import 'widgets/ban_custom_builder_widget.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? "";
    String userType = CacheHelper.getData(key: 'usertype') ?? '';

    return Scaffold(
      appBar: myAppBar(S.of(context).trainer_profile),
      body: BlocBuilder<TrainersCubit, TrainersStates>(
        builder: (context, state) {
          if (state is SucessGetTrainersState) {
            TrainerModel? trainer =
                TrainersCubit.get(context).getTrainer(uid: id);
            return trainer == null
                ? Center(
                    child: Text(S.of(context).no_trainer),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: TrainerContentWidget(trainer: trainer),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (trainer.isBanned == false)
                              if (userType != UserType.admin &&
                                  userType != UserType.trainer)
                                SubButtonWithTrainerWidget(
                                  trainerId: trainer.uid,
                                  traineesCount: trainer.traineesCount,
                                  profits: trainer.profits + trainer.price,
                                  price: trainer.price,
                                ),
                            if (trainer.uid == uid &&
                                userType == UserType.trainer)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: customButton(
                                  onPressed: () {
                                    navigateTo(context,
                                        EditTrainerScreen(model: trainer));
                                  },
                                  lable: S.of(context).edit,
                                ),
                              ),
                            if (userType == UserType.admin)
                              BanCustomBuilderWidget(trainer: trainer),
                          ],
                        ),
                      )
                    ],
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
