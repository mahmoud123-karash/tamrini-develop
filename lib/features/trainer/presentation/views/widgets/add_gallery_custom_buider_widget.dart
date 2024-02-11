import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddGalleryCustomBuilderWidget extends StatelessWidget {
  const AddGalleryCustomBuilderWidget({super.key, required this.trainer});
  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainersCubit, TrainersStates>(
      listener: (context, state) {
        if (state is SucessGetTrainersState) {
          Navigator.pop(context);
          showSnackBar(context, S.of(context).success_add_a);
        }
        if (state is ErrorGetTrainersState) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        List<String> paths = ImageCubit.get(context).paths;
        if (state is LoadingGetTrainersState) {
          return const CircularProgressIndicator();
        }
        return customButton(
          onPressed: () {
            if (paths.length < 2) {
              showSnackBar(context, S.of(context).image_hint);
            } else {
              TrainersCubit.get(context).updateGallery(
                trainer: trainer,
                imgAfter: paths.last,
                imgBefore: paths.first,
              );
            }
          },
          lable: S.of(context).add,
        );
      },
    );
  }
}
