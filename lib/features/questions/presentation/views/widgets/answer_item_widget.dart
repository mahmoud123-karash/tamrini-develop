import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/answer_options_bottom_sheet_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/name_type_answer_user_widget.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';

import '../../../../../generated/l10n.dart';

class AnswerItemWidgt extends StatelessWidget {
  const AnswerItemWidgt({
    super.key,
    required this.model,
    required this.user,
    required this.question,
  });

  final AnswerModel model;
  final QuestionModel question;

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              String uid = CacheHelper.getData(key: 'uid') ?? '';
              if (model.userUid == uid) {
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
                            .getTrainer(uid: model.userUid),
                      ),
                    );
                  } else {
                    navigateTo(context, UserProfileScreen(model: user));
                  }
                }
              }
            },
            child: CircleAvatar(
              radius: 25,
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
            width: 15,
          ),
          NameAswertypeUserWidget(
            name: user.name,
            type: user.role,
            answer: model.answer,
            date: DateFormat('MM/dd/yy', 'en').format(model.date.toDate()),
            time: DateFormat('h:mm a', 'en').format(model.date.toDate()),
          ),
          const Spacer(),
          if (model.userUid == CacheHelper.getData(key: 'uid'))
            InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return AnswerOptionsBottomSheetWidget(
                      model: model,
                      question: question,
                    );
                  },
                );
              },
              child: const Icon(
                Icons.more_vert_sharp,
                size: 18,
              ),
            )
        ],
      ),
    );
  }
}
