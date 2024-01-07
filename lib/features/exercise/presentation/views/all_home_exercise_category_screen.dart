import 'package:flutter/material.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/suggest_exercise_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import '../../data/models/home_exercise/exercise_model.dart';
import 'widgets/home_exercise_list_view_widget.dart';

class AllHomeExercisesCategoryScreen extends StatefulWidget {
  const AllHomeExercisesCategoryScreen({
    Key? key,
    required this.model,
    required this.title,
  }) : super(key: key);
  final List<Data>? model;
  final String title;

  @override
  State<AllHomeExercisesCategoryScreen> createState() =>
      _AllHomeExercisesCategoryScreen();
}

class _AllHomeExercisesCategoryScreen
    extends State<AllHomeExercisesCategoryScreen> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Data> searchList = [];

  int length = 3;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.model!.length > length) {
        length += 5;
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
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SearchTextFieldWidget(
              controller: searchController,
              onChanged: (value) {
                searchList = searchHomeExercise(value, widget.model!);
                if (value == '') {
                  length = 5;
                }
                setState(() {});
              },
            ),
            widget.model != null || widget.model!.isNotEmpty
                ? HomeExerciseListViewWidget(
                    list: searchController.text == ''
                        ? widget.model!
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
