import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/exercise_card_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/serch_hint_colum_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/suggest_exercise_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.exercises});
  final List<DataModel> exercises;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        title: Text(S.of(context).search),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchTextFieldWidget(
              controller: searchController,
              onChanged: (value) {
                searchList = searchExercise(value, widget.exercises);
                setState(() {});
              },
            ),
            if (searchController.text != '')
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ExerciseCardWidget(exercise: searchList[index]);
                },
                itemCount: searchList.length > 10 ? 10 : searchList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 5.h,
                  );
                },
              ),
            if (searchList.isEmpty && searchController.text != '')
              const SuggestExerciseWidget(),
            if (searchController.text == '') const SearchHintColumWidget(),
          ],
        ),
      ),
    );
  }
}
