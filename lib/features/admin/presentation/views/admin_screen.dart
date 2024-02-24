import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/admin/presentation/views/banned_stores_screen.dart';
import 'package:tamrini/features/admin/presentation/views/gyms_banned_screen.dart';
import 'package:tamrini/features/banner/presentation/views/banner_screen.dart';
import 'package:tamrini/features/promotion/presentation/views/promotion_screen.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/suggested_exercises_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'banned_trainers_screen.dart';
import 'users_screen.dart';
import 'widgets/admin_list_tile_widget.dart';
import 'widgets/admin_user_row_widget.dart';
import 'widgets/hello_admin_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).admin_control_panel),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const HelloAdminWidget(),
              const SizedBox(
                height: 15,
              ),
              const AdminUserRowWidget(),
              const SizedBox(
                height: 25,
              ),
              AdminListTileWidget(
                lable: S.of(context).all_users,
                icon: Ionicons.person,
                onPressed: () {
                  navigateTo(
                    context,
                    UsersScreen(
                      title: S.of(context).all_users,
                      usrType: UserType.user,
                    ),
                  );
                },
              ),
              AdminListTileWidget(
                lable: S.of(context).banners,
                icon: Icons.airplay_sharp,
                onPressed: () {
                  navigateTo(context, const BannerScreen());
                },
              ),
              AdminListTileWidget(
                icon: Icons.fitness_center_outlined,
                lable: S.of(context).suggested_exercises,
                onPressed: () {
                  navigateTo(context, const SuggestedExerciseScreen());
                },
              ),
              AdminListTileWidget(
                icon: Icons.store_sharp,
                lable: S.of(context).store_banned,
                onPressed: () {
                  navigateTo(context, const BannedStoreScreen());
                },
              ),
              AdminListTileWidget(
                icon: Icons.fitness_center,
                lable: S.of(context).gyms_banned,
                onPressed: () {
                  navigateTo(context, const BannedGymsScreen());
                },
              ),
              AdminListTileWidget(
                icon: Icons.block_flipped,
                lable: S.of(context).banned_trainers,
                onPressed: () {
                  navigateTo(context, const BannedTrainersScreen());
                },
              ),
              AdminListTileWidget(
                icon: Icons.star,
                lable: S.of(context).promotion,
                onPressed: () {
                  navigateTo(context, const PromotionScreen());
                },
              ),
              AdminListTileWidget(
                icon: Icons.attach_money_rounded,
                lable: S.of(context).profits_request,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
