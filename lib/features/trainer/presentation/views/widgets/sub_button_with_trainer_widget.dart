import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'renew_custom_button_widget.dart';
import 'sub_custom_builder_button_widget.dart';

class SubButtonWithTrainerWidget extends StatefulWidget {
  const SubButtonWithTrainerWidget({
    super.key,
    required this.trainerId,
    required this.traineesCount,
    required this.profits,
  });
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
  Widget build(BuildContext context) {
    return BlocConsumer<TraineeCubit, TraineeStates>(
      listener: (context, state) {
        if (state is SucessGetTraineesState) {
          UserCourseCubit.get(context).getCourse();
        }
      },
      builder: (context, state) {
        String trainerId = CacheHelper.getData(key: 'trainerId') ?? "";
        bool isEndCache = CacheHelper.getData(key: 'isEnd') ?? false;
        if (state is LoadingGetTraineesState) {
          return const CircularProgressIndicator();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (trainerId != '')
                  if (trainerId == widget.trainerId)
                    isEndCache
                        ? ReNewCustomButtonWidget(
                            trainerId: widget.trainerId,
                            traineesCount: widget.traineesCount,
                            profits: widget.profits,
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
                          ),
                if (trainerId != '')
                  if (trainerId != widget.trainerId && isEndCache == true)
                    SubCustomBuilderButtonWidget(
                      trainerId: widget.trainerId,
                      traineesCount: widget.traineesCount,
                      profits: widget.profits,
                    ),
                if (trainerId == '')
                  SubCustomBuilderButtonWidget(
                    trainerId: widget.trainerId,
                    traineesCount: widget.traineesCount,
                    profits: widget.profits,
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
