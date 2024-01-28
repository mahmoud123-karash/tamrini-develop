import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/features/exercise/presentation/manager/swiper_cubit/swiper_cubit.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_assets_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'new_exercise_screen.dart';

class DetailsWithoutVedioScreen extends StatefulWidget {
  const DetailsWithoutVedioScreen({
    Key? key,
    this.isHome = false,
    required this.id,
    this.isAll = false,
  }) : super(key: key);
  final bool isHome, isAll;
  final String id;

  @override
  State<DetailsWithoutVedioScreen> createState() =>
      _DetailsWithoutVedioScreenState();
}

class _DetailsWithoutVedioScreenState extends State<DetailsWithoutVedioScreen> {
  @override
  void initState() {
    CacheHelper.removeData(key: 'index');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(),
        title: Text(
          S.of(context).exDetails,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseStates>(
        builder: (context, state) {
          DataModel model =
              ExerciseCubit.get(context).getExerciseData(dataId: widget.id);
          return Padding(
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
              child: SingleChildScrollView(
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
                      BlocProvider(
                        create: (context) => SwiperCubit(),
                        child: ExerciseAssetsViewWidget(
                          images: model.assets ?? [],
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
                      if (userType == 'admin')
                        if (!widget.isHome && !widget.isAll)
                          customButton(
                            onPressed: () {
                              navigateToAndReplace(
                                  context, NewExerciseScreen(model: model));
                            },
                            lable: S.of(context).edit_exercise,
                          )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
