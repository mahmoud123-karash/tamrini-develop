import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_item_stream_builder_widget.dart';

class QuestionsListViewWidget extends StatefulWidget {
  const QuestionsListViewWidget({super.key, required this.list});
  final List<QuestionModel> list;

  @override
  State<QuestionsListViewWidget> createState() =>
      _QuestionsListViewWidgetState();
}

class _QuestionsListViewWidgetState extends State<QuestionsListViewWidget> {
  ScrollController scrollController = ScrollController();
  var pageBuket = PageStorageBucket();

  int length = 10;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.list.length > length) {
        length += 10;
        WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: pageBuket,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40, top: 10),
        child: ListView.separated(
          key: const PageStorageKey<String>('questions_page'),
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < length) {
              return QuestionItemStreamBuilderWidget(
                model: widget.list[index],
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount:
              widget.list.length < length ? widget.list.length : length + 1,
        ),
      ),
    );
  }
}
