import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'new_gallery_screen.dart';
import 'widgets/trainer_gallery_item_widget.dart';

class TrainerGallerySreen extends StatelessWidget {
  const TrainerGallerySreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    String userType = CacheHelper.getData(key: 'usertype');

    return Scaffold(
      appBar: myAppBar(
        S.of(context).trainer_gallery,
      ),
      body: Builder(builder: (context) {
        return BlocBuilder<TrainersCubit, TrainersStates>(
          builder: (context, state) {
            TrainerModel? model =
                TrainersCubit.get(context).getTrainer(uid: id);

            return model == null
                ? Center(
                    child: Text(S.of(context).no_trainer),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        if (model.uid == uid && userType == UserType.trainer)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: addCustomButton(
                              onPressed: () {
                                navigateTo(
                                    context, NewGalleryScreen(trainer: model));
                              },
                              lable: S.of(context).add_new_gallery,
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: model.gallery.isEmpty
                              ? Center(
                                  child: Text(
                                    S.of(context).no_results,
                                  ),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) =>
                                      TrainerGalleryItemWidget(
                                    model: model.gallery[index],
                                    trainer: model,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 20,
                                  ),
                                  itemCount: model.gallery.length,
                                ),
                        ),
                      ],
                    ),
                  );
          },
        );
      }),
    );
  }
}
