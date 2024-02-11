import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'sub_custom_builder_button_widget.dart';

class SubButtonWithTrainerWidget extends StatefulWidget {
  const SubButtonWithTrainerWidget(
      {super.key,
      required this.trainerId,
      required this.traineesCount,
      required this.profits});
  final String trainerId;
  final int traineesCount;
  final num profits;

  @override
  State<SubButtonWithTrainerWidget> createState() =>
      _SubButtonWithTrainerWidgetState();
}

class _SubButtonWithTrainerWidgetState
    extends State<SubButtonWithTrainerWidget> {
  @override
  void initState() {
    if (mounted) {
      TraineeCubit.get(context).getData(trainerId: widget.trainerId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: BlocBuilder<TraineeCubit, TraineeStates>(
        builder: (context, state) {
          String trainerId = CacheHelper.getData(key: 'trainerId') ?? "";

          if (state is LoadingGetTraineesState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<TraineeModel> trainees = TraineeCubit.get(context).trainees;
            if (trainees.any((element) => element.uid == uid)) {
              TraineeModel model =
                  trainees.firstWhere((element) => element.uid == uid);
              DateTime endDate = model.dateOfSubscription
                  .toDate()
                  .add(const Duration(days: 30));
              return endDate.isBefore(DateTime.now())
                  ? customButton(
                      onPressed: () {},
                      lable: S.of(context).renew_sub,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        S.of(context).you_sub_with_trainer,
                        style: TextStyles.style14.copyWith(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
            } else {
              return trainerId != ''
                  ? Container()
                  : SubCustomBuilderButtonWidget(
                      trainerId: widget.trainerId,
                      traineesCount: widget.traineesCount,
                      profits: widget.profits,
                    );
            }
          }
        },
      ),
    );
  }
}
