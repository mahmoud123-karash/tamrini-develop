import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/gym_row_info_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../profits/presentation/views/profits_screen.dart';
import 'widgets/ban_gym_container_widget.dart';
import 'widgets/edit_gym_row_widget.dart';
import 'widgets/gym_slide_show_images_widget.dart';
import 'widgets/no_gym_message_widget.dart';

class GymOwnerScreen extends StatelessWidget {
  const GymOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return Scaffold(
      appBar: myAppBar(
        S.of(context).gym_owner,
      ),
      body: BlocBuilder<GymCubit, GymStates>(
        builder: (context, state) {
          if (state is SucessGetGymsState) {
            List<GymModel> list = GymCubit.get(context).getUserGym(uid);
            GymModel? model = list.isEmpty ? null : list.first;
            return model == null
                ? const NoGymMessageWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (model.isBanned)
                        BanGymContainerWidget(
                          message: S.of(context).banned_gym_hint,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Text(
                          model.name,
                          style:
                              TextStyles.style20Bold.copyWith(color: appColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: ListTile(
                          onTap: () {
                            navigateTo(
                                context,
                                ProfitsScreen(
                                  profits: model.profits,
                                  id: model.id,
                                ));
                          },
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: appColor,
                            ),
                          ),
                          leading: Icon(
                            Icons.attach_money_rounded,
                            color: appColor,
                          ),
                          title: Text(
                            S.of(context).profits,
                            style: TextStyles.style13.copyWith(
                              color: appColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: appColor,
                          ),
                        ),
                      ),
                      GymRowInfoWidget(
                        model: model,
                      ),
                      model.assets.isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GymSlideShowImagesWidget(
                                assets: model.assets,
                                name: model.name,
                              ),
                            ),
                      const Spacer(),
                      if (!model.isBanned) EditGymRowWidget(model: model),
                    ],
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
