import 'package:flutter/material.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/suggest_exercise_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/exercise_list_view_widget.dart';

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
      if (widget.model.data!.length > length) {
        length += 10;
        WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
        title: Text(widget.model.title ?? ''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SearchTextFieldWidget(
              controller: searchController,
              onChanged: (value) {
                searchList = searchExercise(value, widget.model.data!);
                if (value == '') {
                  length = 10;
                }
                setState(() {});
              },
            ),
            widget.model.data != null || widget.model.data!.isNotEmpty
                ? ExerciseListViewWidget(
                    list: searchController.text == ''
                        ? widget.model.data!
                        : searchList,
                    length: length,
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
