import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/exercise_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ExerciseCoursesScreen extends StatelessWidget {
  const ExerciseCoursesScreen({
    super.key,
    required this.dayName,
    required this.list,
    required this.themeColor,
  });
  final String dayName;
  final List<DataModel> list;
  final Color themeColor;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: themeAppBar(
        dayName,
        backgroundColor: themeColor,
      ),
      body: list.isEmpty
          ? Center(
              child: Text(
                S.of(context).emptyList,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (context, index) => ExerciseItemWidget(
                  model: list[index],
                  width: width,
                  num: 100,
                  themeColor: themeColor,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: list.length,
              ),
            ),
    );
  }
}
