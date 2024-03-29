import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/new_exercise_screen.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/widgets/suggest_exercise_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'exercise_list_view_widget.dart';

class AllExercisesCategoryContentWidget extends StatefulWidget {
  const AllExercisesCategoryContentWidget({
    Key? key,
    required this.list,
    this.isAll = false,
    required this.isCourse,
  }) : super(key: key);
  final List<DataModel> list;
  final bool isAll;
  final bool isCourse;

  @override
  State<AllExercisesCategoryContentWidget> createState() =>
      _AllExercisesCategoryContentWidget();
}

class _AllExercisesCategoryContentWidget
    extends State<AllExercisesCategoryContentWidget> {
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() {});
          });
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
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Column(
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
        if (userType == "admin" || userType == 'writer')
          if (!widget.isAll)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: addCustomButton(
                onPressed: () {
                  navigateTo(context, const NewExerciseScreen());
                },
                lable: S.of(context).add_exercise,
              ),
            ),
        widget.list.isNotEmpty
            ? Expanded(
                child: ExerciseListViewWidget(
                  scrollController: scrollController,
                  list: searchController.text == '' ? widget.list : searchList,
                  length: length,
                  isAll: widget.isAll,
                  isCourse: widget.isCourse,
                ),
              )
            : Expanded(
                child: Center(
                  child: Text(
                    S.of(context).emptyList,
                  ),
                ),
              ),
        if (searchList.isEmpty && searchController.text != '')
          const Expanded(
            child: SuggestExerciseWidget(),
          ),
      ],
    );
  }
}
