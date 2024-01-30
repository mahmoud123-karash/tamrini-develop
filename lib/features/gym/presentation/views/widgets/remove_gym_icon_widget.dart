import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveGymIconWidget extends StatelessWidget {
  const RemoveGymIconWidget(
      {super.key,
      required this.id,
      required this.title,
      required this.assests});
  final String id, title;
  final List<String> assests;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircleAvatar(
          backgroundColor: Colors.amber.withOpacity(0.6),
          child: Center(
            child: IconButton(
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
                  title: title,
                  desc: S.of(context).gym_removed_hint,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    GymCubit.get(context).removeGym(
                      images: assests,
                      id: id,
                      context: context,
                    );
                  },
                ).show();
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
