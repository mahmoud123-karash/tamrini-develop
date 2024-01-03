// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/suggest_exercise_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/exercise_card_widget.dart';

class AllExercisesCategoryScreen extends StatefulWidget {
  const AllExercisesCategoryScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final ExerciseModel model;

  @override
  State<AllExercisesCategoryScreen> createState() =>
      _AllExercisesCategoryScreen();
}

class _AllExercisesCategoryScreen extends State<AllExercisesCategoryScreen> {
  final TextEditingController searchController = TextEditingController();
  List<DataModel> searchList = [];
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.title ?? ''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchTextFieldWidget(
              controller: searchController,
              onChanged: (value) {
                searchList = searchExercise(value, widget.model.data!);
                setState(() {});
              },
            ),
            widget.model.data != null || widget.model.data!.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ExerciseCardWidget(
                        exercise: searchController.text != ''
                            ? searchList[index]
                            : widget.model.data![index],
                      );
                    },
                    itemCount: searchController.text != ''
                        ? searchList.length > 10
                            ? 10
                            : searchList.length
                        : widget.model.data!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5.h,
                      );
                    },
                  )
                : Center(
                    child: Text(
                      S.of(context).emptyList,
                    ),
                  ),
            if (searchList.isEmpty && searchController.text != '')
              const SuggestExerciseWidget(),
          ],
        ),
      ),
    );
  }
}
