import 'package:flutter/widgets.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/article_list_view_widget.dart';

class PendingListViewBuilderWidget extends StatefulWidget {
  const PendingListViewBuilderWidget({super.key, required this.list});
  final List<ArticleModel> list;

  @override
  State<PendingListViewBuilderWidget> createState() =>
      _PendingListViewBuilderWidgetState();
}

class _PendingListViewBuilderWidgetState
    extends State<PendingListViewBuilderWidget> {
  ScrollController scrollController = ScrollController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,),
      child: ArticleListViewWidget(
        list: widget.list,
        length: length,
        controller: scrollController,
      ),
    );
  }
}
