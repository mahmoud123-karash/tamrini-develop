import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/courses_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'diet_course_screen.dart';
import 'follow_screen.dart';
import 'trainee_supplement_screen.dart';
import 'widgets/trainee_list_tile_widget.dart';

class TraineeScreen extends StatelessWidget {
  const TraineeScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).trainee_profile),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: user.image != ''
                    ? FirebaseImageProvider(
                        FirebaseUrl(user.image),
                      )
                    : const AssetImage(Assets.imagesProfile) as ImageProvider,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              user.name,
              style: TextStyles.style16Bold.copyWith(
                color: appColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                navigateTo(context, UserProfileScreen(model: user));
              },
              child: Text(S.of(context).user_profile),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Intl.getCurrentLocale() == 'ar'
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  S.of(context).training_course,
                  style: TextStyles.style16Bold.copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TraineeListTileWidget(
              lable: S.of(context).follow_and_data,
              icon: Icons.follow_the_signs_rounded,
              onTap: () {
                navigateTo(context, const FollowScreen());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TraineeListTileWidget(
              lable: S.of(context).courses,
              icon: Icons.golf_course_outlined,
              onTap: () {
                navigateTo(context, const CourcesScreen());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TraineeListTileWidget(
              lable: S.of(context).diet,
              icon: Icons.fastfood_outlined,
              onTap: () {
                navigateTo(context, const DietCourseScreen());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TraineeListTileWidget(
              lable: S.of(context).nuttritions,
              icon: Icons.local_drink_outlined,
              onTap: () {
                navigateTo(context, const TraineeSupplementsScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
