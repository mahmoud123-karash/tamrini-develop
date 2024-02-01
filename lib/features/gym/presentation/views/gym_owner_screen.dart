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

import 'widgets/ban_gym_container_widget.dart';
import 'widgets/edit_gym_row_widget.dart';
import 'widgets/gym_slide_show_images_widget.dart';
import 'widgets/no_gym_message_widget.dart';

class GymOwnerScreen extends StatelessWidget {
  const GymOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return Scaffold(
      appBar: myAppBar(
        S.of(context).gym_owner,
      ),
      body: BlocBuilder<GymCubit, GymStates>(
        builder: (context, state) {
          List<GymModel> list = GymCubit.get(context).getUserGym(uid);
          GymModel? model = list.isEmpty ? null : list.first;
          return model == null
              ? const NoGymMessageWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.isBanned) const BanGymContainerWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Text(
                        model.name,
                        style: TextStyles.style20Bold.copyWith(color: appColor),
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
        },
      ),
    );
  }
}
