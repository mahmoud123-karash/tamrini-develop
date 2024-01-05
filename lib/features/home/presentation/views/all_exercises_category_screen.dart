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
  ScrollController scrollController = ScrollController();
  List<DataModel> searchList = [];

  int length = 10;
  int sLength = 10;

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

        setState(() {});
      }
      if (searchList.length > sLength) {
        sLength += 10;
        setState(() {});
      }
      if (searchController.text == '') {
        sLength = 10;
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
                setState(() {});
              },
            ),
            widget.model.data != null || widget.model.data!.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < length) {
                        return ExerciseCardWidget(
                          exercise: searchController.text != ''
                              ? searchList[index]
                              : widget.model.data![index],
                        );
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                    itemCount: searchController.text != ''
                        ? searchList.length < sLength
                            ? searchList.length
                            : sLength + 1
                        : widget.model.data!.length < length
                            ? widget.model.data!.length
                            : length + 1,
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
