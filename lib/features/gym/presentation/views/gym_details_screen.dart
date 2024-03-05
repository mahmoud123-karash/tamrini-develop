import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/gym/presentation/views/new_gym_screen.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/ban_gym_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/gym_details_content_widget.dart';
import 'widgets/no_gym_message_widget.dart';
import 'widgets/sub_gym_builder_widget.dart';

class GymDetailsScreen extends StatelessWidget {
  const GymDetailsScreen({super.key, required this.gymId});
  final String gymId;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;

    log(gymId);
    return Scaffold(
      appBar: myAppBar(S.of(context).gym_details),
      body: BlocBuilder<GymCubit, GymStates>(
        builder: (context, state) {
          List<GymModel> list = GymCubit.get(context).getGym(gymId);
          GymModel? model = list.isEmpty ? null : list.first;
          return model == null
              ? const NoGymMessageWidget()
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: double.infinity,
                    height: getHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            child: GymDetailsContentWidget(model: model),
                          ),
                        ),
                        SubAndEditCustomWidget(model: model),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class SubAndEditCustomWidget extends StatelessWidget {
  const SubAndEditCustomWidget({super.key, required this.model});
  final GymModel model;
  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? "";
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (userType == UserType.admin || userType == UserType.gymOwner)
          model.ownerUid == uid
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customButton(
                    onPressed: () {
                      if (model.isBanned) {
                        showSnackBar(context, S.of(context).no_edit_ban);
                      } else {
                        navigateTo(context, NewGymScreen(model: model));
                      }
                    },
                    lable: S.of(context).edit,
                  ),
                )
              : Container(),
        if (model.ownerUid != adminUid && model.isBanned == false)
          SubGymBuilderWidget(model: model),
        if (userType == UserType.admin && model.ownerUid != uid)
          BanGymCustomButtonWidget(
            uid: model.id,
            title: model.name,
            ownerId: model.ownerUid,
            isBanned: model.isBanned,
          ),
      ],
    );
  }
}
