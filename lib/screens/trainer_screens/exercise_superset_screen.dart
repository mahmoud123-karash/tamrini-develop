import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/exercise_provider.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/utils/distripute_assets.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../../model/exercise.dart';
import '../../utils/widgets/custom_image_slide_show.dart';

class ExerciseSupersetScreen extends StatefulWidget {
  final Exercise exercise;
  final Data? mainExercise;
  final bool isAll;
  final String dayID;

  const ExerciseSupersetScreen({
    Key? key,
    required this.exercise,
    required this.isAll,
    required this.mainExercise,
    required this.dayID,
    // required this.course
  }) : super(key: key);

  @override
  State<ExerciseSupersetScreen> createState() => _ExerciseSupersetScreen();
}

class _ExerciseSupersetScreen extends State<ExerciseSupersetScreen> {
  Data? selectedExercise;

  void manageSuperSetToTrainee(
    TraineeProvider traineeProvider,
    int index,
    bool value,
  ) {
    setState(() {
      if (value == true) {
        selectedExercise =
            traineeProvider.exerciseProvider.selectedSuperSetExercise[index];
      } else {
        selectedExercise = null;
      }
    });
  }

  @override
  void dispose() {
    Provider.of<ExerciseProvider>(navigationKey.currentContext!, listen: false)
        .clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: globalAppBar("التمارين", actions: [
          IconButton(
            icon: const Icon(Icons.save),
            color: Colors.white,
            onPressed: () async {
              await Provider.of<TraineeProvider>(context, listen: false)
                  .addSuperSetToExercise(
                widget.mainExercise,
                selectedExercise,
                widget.dayID,
              );
              pop();
            },
          ),
        ]),
        body: Consumer<TraineeProvider>(builder: (context, _, child) {
          return _.exerciseProvider.isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Image.asset('assets/images/loading.gif',
                        height: 100.h, width: 100.w),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      searchBar(_.exerciseProvider.searchController, (value) {
                        widget.isAll
                            ? _.exerciseProvider.searchAll()
                            : _.exerciseProvider.search(widget.exercise.id);
                        _.exerciseProvider.searchAll();
                      }),
                      (_.exerciseProvider.selectedSuperSetExercise == null ||
                                  _.exerciseProvider.selectedSuperSetExercise
                                      .isEmpty) &&
                              !_.exerciseProvider.searchController.text.isEmpty
                          ? const Center(
                              child: Text("لا يوجد تمارين بهذا الإسم"),
                            )
                          : _.exerciseProvider.selectedSuperSetExercise ==
                                      null ||
                                  _.exerciseProvider.selectedSuperSetExercise
                                      .isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                              2 -
                                          100.h),
                                  child: const Center(
                                    child: Text('لا يوجد تمارين'),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    List<Widget> assets = [];
                                    if (_
                                            .exerciseProvider
                                            .selectedSuperSetExercise[index]
                                            .assets !=
                                        null) {
                                      assets = distributeAssets(_
                                          .exerciseProvider
                                          .selectedSuperSetExercise[index]
                                          .assets! as List<String>);
                                    }
                                    return ExerciseCard(
                                      index: index,
                                      assets: assets,
                                      traineeProvider: _,
                                      onSelectExercise: (value) =>
                                          manageSuperSetToTrainee(
                                              _, index, value),
                                      selectedExercise: selectedExercise,
                                    );
                                  },
                                  itemCount: _.exerciseProvider
                                      .selectedSuperSetExercise.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 5.h,
                                    );
                                  },
                                )
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final int index;
  final List<Widget> assets;
  final TraineeProvider traineeProvider;
  final Data? selectedExercise;
  final void Function(bool) onSelectExercise;

  const ExerciseCard(
      {required this.index,
      required this.assets,
      required this.traineeProvider,
      required this.selectedExercise,
      required this.onSelectExercise,
      Key? key})
      : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print('from tap');
          widget.onSelectExercise(true);
        },
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget
                                    .traineeProvider
                                    .exerciseProvider
                                    .selectedSuperSetExercise![widget.index]
                                    .assets ==
                                null ||
                            widget
                                .traineeProvider
                                .exerciseProvider
                                .selectedSuperSetExercise[widget.index]
                                .assets!
                                .isEmpty
                        ? const SizedBox()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CustomImageSlideShow(
                              assets: widget
                                  .traineeProvider
                                  .exerciseProvider
                                  .selectedSuperSetExercise[widget.index]
                                  .assets!,
                              children: widget.assets,
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.traineeProvider.exerciseProvider
                              .selectedSuperSetExercise[widget.index].title!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget
                              .traineeProvider
                              .exerciseProvider
                              .selectedSuperSetExercise[widget.index]
                              .description!,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15.sm,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Checkbox(
                  value: widget.selectedExercise?.id ==
                      widget.traineeProvider.exerciseProvider
                          .selectedSuperSetExercise[widget.index].id,
                  onChanged: (value) {
                    print('checkbox checked: ${value}');
                    widget.onSelectExercise(value == true);

                    // TODO check here to add setState and after is selected check to add the value in the provider like other props
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
