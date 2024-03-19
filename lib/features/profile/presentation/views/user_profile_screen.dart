import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/gym_owner_profile_widget.dart';
import 'widgets/store_owner_profile_widget.dart';
import 'widgets/user_profile_content_widget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).user_profile),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            UserProfileContentWidget(model: model),
            const SizedBox(
              height: 30,
            ),
            if (model.role == UserType.gymOwner)
              GymOwnerProfileWidget(
                list: GymCubit.get(context).getUserGym(
                  model.uid,
                ),
              ),
            if (model.role == UserType.storeOwner)
              StoreOwnerProfileWidget(
                list: StoreCubit.get(context).getStore(
                  model.uid,
                ),
              )
          ],
        ),
      ),
    );
  }
}
