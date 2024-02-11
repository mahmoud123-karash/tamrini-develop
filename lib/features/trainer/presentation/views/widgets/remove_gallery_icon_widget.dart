import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/gallery_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveGalleryIconWidget extends StatelessWidget {
  const RemoveGalleryIconWidget({
    super.key,
    required this.trainer,
    required this.model,
  });
  final TrainerModel trainer;
  final GalleryModel model;
  @override
  Widget build(BuildContext context) {
    return IconButton(
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
          desc: S.of(context).remove_gallery_hint,
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            TrainersCubit.get(context).removeGallery(
              trainer: trainer,
              model: model,
              message: S.of(context).success_remove,
            );
          },
        ).show();
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
