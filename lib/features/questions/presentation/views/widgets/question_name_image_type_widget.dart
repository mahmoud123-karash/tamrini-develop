// ignore_for_file: file_names

import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/options_bottom_sheet_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_owner_name_type_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../../core/shared/components.dart';
import '../../../../trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';

class QuestionOwnerNameImageTypeWidget extends StatelessWidget {
  const QuestionOwnerNameImageTypeWidget({
    super.key,
    required this.user,
    required this.model,
    required this.isDetails,
  });
  final UserModel user;
  final QuestionModel model;
  final bool isDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            String uid = CacheHelper.getData(key: 'uid') ?? '';
            if (model.askerUid == uid) {
              navigateTo(context, const ProfileScreen());
            } else {
              if (user.role == 'admin') {
                showSnackBar(context, S.of(context).admin_hint);
              } else {
                if (user.role == 'captain') {
                  navigateTo(
                    context,
                    TrainerProfileScreen(
                      trainer: TrainersCubit.get(context)
                          .getTrainer(uid: model.askerUid),
                    ),
                  );
                } else {
                  navigateTo(context, UserProfileScreen(model: user));
                }
              }
            }
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: user.image != ''
                ? FirebaseImageProvider(
                    FirebaseUrl(user.image),
                  ) as ImageProvider
                : const AssetImage(
                    Assets.imagesProfile,
                  ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        QuestionOwnerNameTypeWidgt(
          name: user.name,
          role: user.role,
        ),
        const Spacer(),
        if (user.uid == CacheHelper.getData(key: 'uid') || user.uid == adminUid)
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              showModalBottomSheet(
                useRootNavigator: true,
                context: context,
                builder: (context) => OptionsBottomSheetWidget(
                  model: model,
                  isAdmin: user.uid == adminUid,
                  isDetails: isDetails,
                ),
              );
            },
            child: const Icon(Icons.more_vert_sharp),
          ),
      ],
    );
  }
}