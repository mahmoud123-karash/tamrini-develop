import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/gym/presentation/views/new_gym_screen.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/gym_custom_buttons_widget.dart';
import 'widgets/gym_details_content_widget.dart';

class GymDetailsScreen extends StatelessWidget {
  const GymDetailsScreen({super.key, required this.gymId});
  final String gymId;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');
    log(gymId);
    return Scaffold(
      appBar: myAppBar(S.of(context).gym_details),
      body: BlocBuilder<GymCubit, GymStates>(
        builder: (context, state) {
          List<GymModel> list = GymCubit.get(context).getGym(gymId);
          GymModel? model = list.isEmpty ? null : list.first;
          return model == null
              ? Center(
                  child: Text(S.of(context).gym_remove_hint),
                )
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
                        if (model.ownerUid == uid)
                          userType == 'admin' || userType == 'gym_onwer'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: customButton(
                                    onPressed: () {
                                      navigateTo(
                                          context, NewGymScreen(model: model));
                                    },
                                    lable: S.of(context).edit,
                                  ),
                                )
                              : GymCustomButtonsWidget(
                                  lat: model.location.latitude,
                                  long: model.location.longitude,
                                ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
