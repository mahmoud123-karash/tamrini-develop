import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home_exercise/presentation/views/new_home_exercise_screen.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/widgets/suggest_exercise_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import '../../data/models/home_exercise/exercise_data.dart';
import 'widgets/home_exercise_list_view_widget.dart';

class AllHomeExercisesCategoryScreen extends StatefulWidget {
  const AllHomeExercisesCategoryScreen({
    Key? key,
    required this.models,
    required this.title,
    this.isAll = false,
  }) : super(key: key);
  final List<Data> models;
  final String title;
  final bool isAll;

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
      if (widget.models.length > length) {
        length += 5;
        Future.delayed(const Duration(seconds: 1)).then(
          (value) {
            if (mounted) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => setState(() {}));
            }
          },
        );
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
    String userType = CacheHelper.getData(key: 'usertype');
    return Scaffold(
      appBar: myAppBar(
        widget.title,
      ),
      body: Column(
        children: [
          searchField(
            controller: searchController,
            onChanged: (value) {
              searchList = searchHomeExercise(value, widget.models);
              if (value == '') {
                length = 5;
              }
              setState(() {});
            },
          ),
          if (!widget.isAll)
            if (userType == 'admin' || userType == 'writer')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: addCustomButton(
                  onPressed: () {
                    navigateTo(context, const NewHomeExerciseScreen());
                  },
                  lable: S.of(context).add_new_exercise,
                ),
              ),
          widget.models.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      S.of(context).emptyList,
                    ),
                  ),
                )
              : Expanded(
                  child: HomeExerciseListViewWidget(
                    isAll: widget.isAll,
                    scrollController: scrollController,
                    list: searchController.text == ''
                        ? widget.models
                        : searchList,
                    length: length,
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
