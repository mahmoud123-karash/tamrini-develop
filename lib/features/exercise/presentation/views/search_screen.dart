import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_card_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/search_hint_colum_widget.dart';
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
  ScrollController scrollController = ScrollController();
  List<DataModel> searchList = [];

  int length = 10;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.exercises.length > length) {
        length += 10;
        setState(() {});
      }

      if (searchController.text == '') {
        length = 10;
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
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
        controller: scrollController,
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
                  if (index < length) {
                    return ExerciseCardWidget(exercise: searchList[index]);
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
                itemCount:
                    searchList.length < length ? searchList.length : length + 1,
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
