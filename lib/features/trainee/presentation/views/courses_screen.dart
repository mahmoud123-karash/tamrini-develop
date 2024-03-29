import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/courses_content_widgt.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/theme_cubit/theme_states.dart';

class CourcesScreen extends StatefulWidget {
  const CourcesScreen(
      {super.key, required this.traineeId, this.list, required this.logo});
  final String traineeId;
  final List<CourseModel>? list;
  final String logo;

  @override
  State<CourcesScreen> createState() => _CourcesScreenState();
}

class _CourcesScreenState extends State<CourcesScreen> {
  ScrollController scrollController = ScrollController();

  int length = 10;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.list!.length > length) {
        length += 10;
        Future.delayed(const Duration(seconds: 1)).then((value) {
          if (mounted) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setState(() {}));
          }
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeStates>(
      builder: (context, state) {
        Color themeColor = ThemeCubit.get(context).themeColor;
        return Scaffold(
          appBar: themeAppBar(
            S.of(context).courses,
            backgroundColor: themeColor,
          ),
          body: BlocBuilder<TraineeCubit, TraineeStates>(
            builder: (context, state) {
              TraineeModel? model = widget.list != null
                  ? null
                  : TraineeCubit.get(context).getTrainee(id: widget.traineeId);
              List<CourseModel> courses = widget.list ?? model!.courses;
              return CoursesContentWidget(
                themeColor: themeColor,
                courses: courses,
                model: model,
                length: length,
                logo: widget.logo,
              );
            },
          ),
        );
      },
    );
  }
}
