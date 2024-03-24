import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
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
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    String cachedUid = CacheHelper.getData(key: 'uid') ?? '';
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            String uid = CacheHelper.getData(key: 'uid') ?? '';
            if (model.askerUid == uid) {
              navigateTo(context, const ProfileScreen());
            } else {
              if (user.role == UserType.admin) {
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
        if (user.uid == cachedUid && userType != UserType.admin)
          BlocProvider(
            create: (context) => UserCubit()..getUser(uid: cachedUid),
            child: BlocBuilder<UserCubit, UserStates>(
              builder: (context, state) {
                if (state is SucessGetUserState) {
                  if (state.model.isBanned) {
                    return Container();
                  } else {
                    return QuestionOptionWidget(
                      user: user,
                      model: model,
                      isDetails: isDetails,
                    );
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
        if (userType == UserType.admin)
          QuestionOptionWidget(
            user: user,
            model: model,
            isDetails: isDetails,
          ),
      ],
    );
  }
}

class QuestionOptionWidget extends StatelessWidget {
  const QuestionOptionWidget({
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
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (context) => OptionsBottomSheetWidget(
            model: model,
            isAdmin: CacheHelper.getData(key: 'usertype') == UserType.admin,
            isDetails: isDetails,
            token: user.token,
          ),
        );
      },
      child: const Icon(Icons.more_vert_sharp),
    );
  }
}
