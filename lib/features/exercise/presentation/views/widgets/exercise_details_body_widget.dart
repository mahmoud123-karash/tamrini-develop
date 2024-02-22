import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/core/widgets/user_builder_widget.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'custom_image_slide_show.dart';
import 'edit_exercise_custom_button_widget.dart';

class ExerciseDetailsBodyWidget extends StatelessWidget {
  const ExerciseDetailsBodyWidget({
    super.key,
    required this.id,
    required this.isHome,
    required this.isAll,
    this.player,
  });
  final String id;
  final bool isHome, isAll;
  final Widget? player;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseStates>(
      builder: (context, state) {
        DataModel? model =
            ExerciseCubit.get(context).getExerciseData(dataId: id);
        return model == null
            ? Center(
                child: Text(S.of(context).emptyList),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  model.title ?? '',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: Intl.getCurrentLocale() == 'en'
                                      ? TextAlign.end
                                      : TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: CustomImageSlideShow(
                                  assets: model.assets ?? [],
                                  children: distributeAssets(
                                    model.assets ?? [],
                                    player: player,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    """${(model.description)}""",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Divider(),
                              UserBuilderWidget(
                                uid: model.writerUid ?? adminUid,
                              ),
                              if (!isHome && !isAll)
                                EditExerciseCustomButtonWidget(model: model)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
