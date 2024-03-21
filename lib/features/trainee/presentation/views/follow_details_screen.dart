import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/gym_slide_show_images_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/follow_details_item_widget.dart';

class FollowDetailsScreen extends StatelessWidget {
  const FollowDetailsScreen({super.key, required this.model});
  final FollowUpModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeStates>(
      builder: (context, state) {
        Color themeColor = ThemeCubit.get(context).themeColor;
        return Scaffold(
          appBar: themeAppBar(S.of(context).follow_details,
              backgroundColor: themeColor),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                width: double.infinity,
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
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEE, M/d/y', 'en').format(
                                model.createdAt.toDate(),
                              ),
                              style: TextStyles.style14.copyWith(
                                color: themeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GymSlideShowImagesWidget(
                                assets: model.images,
                                name: DateFormat('EEE, M/d/y').format(
                                  model.createdAt.toDate(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  FollowDetailsItemWidget(
                                themeColor: themeColor,
                                question: model.followUpData[index].question,
                                answer: model.followUpData[index].answer,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 15,
                              ),
                              itemCount: model.followUpData.length,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
