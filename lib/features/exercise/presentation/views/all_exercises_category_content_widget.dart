import 'package:flutter/material.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/new_exercise_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/suggest_exercise_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/exercise_list_view_widget.dart';

class AllExercisesCategoryContentWidget extends StatefulWidget {
  const AllExercisesCategoryContentWidget({
    Key? key,
    required this.list,
    this.isAll = false,
  }) : super(key: key);
  final List<DataModel> list;
  final bool isAll;

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
