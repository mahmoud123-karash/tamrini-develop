import 'package:flutter/material.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/suggest_exercise_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/exercise_list_view_widget.dart';

class AllExercisesCategoryScreen extends StatefulWidget {
  const AllExercisesCategoryScreen({
    Key? key,
    required this.list,
    required this.title,
  }) : super(key: key);
  final List<DataModel> list;
  final String title;

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
    scrollController.addListener(_loadMoreData);
    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.list.length > length) {
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
      body: Column(
        children: [
          searchField(
            controller: searchController,
            onChanged: (value) {
              searchList = searchExercise(value, widget.list);
              if (value == '') {
                length = 10;
              }
              setState(() {});
            },
          ),
          widget.list.isNotEmpty
              ? Expanded(
                  child: ExerciseListViewWidget(
                    scrollController: scrollController,
                    list:
                        searchController.text == '' ? widget.list : searchList,
                    length: length,
                  ),
                )
              : Center(
                  child: Text(
                    S.of(context).emptyList,
                  ),
                ),
          if (searchList.isEmpty && searchController.text != '')
            const Expanded(
              child: SuggestExerciseWidget(),
            ),
        ],
      ),
    );
  }
}
