import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/add_article_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/article_model/article_model.dart';
import 'article_list_view_widget.dart';

class AllArticleContentWidget extends StatefulWidget {
  const AllArticleContentWidget({
    super.key,
    required this.length,
    required this.list,
    required this.isWriter,
  });
  final List<ArticleModel> list;
  final bool isWriter;
  final int length;

  @override
  State<AllArticleContentWidget> createState() =>
      _AllArticleContentWidgetState();
}

class _AllArticleContentWidgetState extends State<AllArticleContentWidget> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<ArticleModel> searchList = [];

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
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');

    return Column(
      children: [
        searchField(
          controller: searchController,
          onChanged: (value) {
            searchList = searchArticles(value, widget.list);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        if (userType == 'admin' || widget.isWriter)
          AddArticleRowWidget(
            length: widget.length,
            isWriter: widget.isWriter,
          ),
        const SizedBox(
          height: 15,
        ),
        widget.list.isNotEmpty
            ? Expanded(
                child: ArticleListViewWidget(
                  controller: scrollController,
                  list: searchController.text == '' ? widget.list : searchList,
                  length: length,
                ),
              )
            : Expanded(
                child: Center(
                  child: Text(
                    S.of(context).no_results,
                  ),
                ),
              ),
        if (searchList.isEmpty && searchController.text != '')
          Expanded(
            child: Text(
              S.of(context).noArticles,
              style: TextStyles.style20,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
