// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/options_bottom_sheet_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_owner_name_type_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../../core/shared/components.dart';

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
                if (user.role == UserType.trainer) {
                  navigateTo(
                    context,
                    TrainerProfileScreen(id: model.askerUid),
                  );
                } else {
                  navigateTo(context, UserProfileScreen(model: user));
                }
              }
            }
          },
          child: CirclarImageWidget(
            radius: 30,
            image: user.image,
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
        if (user.uid == CacheHelper.getData(key: 'uid') ||
            CacheHelper.getData(key: 'usertype') == UserType.admin)
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              showModalBottomSheet(
                useRootNavigator: true,
                context: context,
                builder: (context) => OptionsBottomSheetWidget(
                  model: model,
                  isAdmin:
                      CacheHelper.getData(key: 'usertype') == UserType.admin,
                  isDetails: isDetails,
                  token: user.token,
                ),
              );
            },
            child: const Icon(Icons.more_vert_sharp),
          ),
      ],
    );
  }
}
