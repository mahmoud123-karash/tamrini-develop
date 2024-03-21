import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddSupplementRowButtonsWidget extends StatelessWidget {
  const AddSupplementRowButtonsWidget(
      {super.key, required this.supplememnts, required this.model});
  final List<String> supplememnts;
  final TraineeModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return Row(
      children: [
        Expanded(
          child: BlocConsumer<TraineeCubit, TraineeStates>(
            listener: (context, state) {
              if (state is LoadingGetTraineesState) {
                showLoaderDialog(context);
              }
              if (state is ErrorGetTraineesState) {
                showSnackBar(context, state.message);
                TraineeCubit.get(context).getData(trainerId: uid);
              }
              if (state is SucessGetTraineesState) {
                showSnackBar(context, S.of(context).success_add_a);
                CourseCubit.get(context).clearSupplement();
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return customButton(
                color: ThemeCubit.get(context).themeColor,
                onPressed: () {
                  TraineeCubit.get(context).addSupplements(
                    model: model,
                    supplements: supplememnts,
                  );
                },
                lable: S.of(context).add,
              );
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: customButton(
            color: Colors.red.withOpacity(0.7),
            onPressed: () {
              CourseCubit.get(context).clearSupplement();
            },
            lable: S.of(context).cancel,
          ),
        ),
      ],
    );
  }
}
