import 'package:flutter/material.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/article_model/article_model.dart';
import 'add_article_custom_button_widget.dart';
import 'article_list_view_widget.dart';

class AllArticleContentWidget extends StatefulWidget {
  const AllArticleContentWidget({
    super.key,
    required this.length,
    required this.list,
    required this.isWriter,
    required this.isUserProfile,
  });
  final List<ArticleModel> list;
  final bool isWriter, isUserProfile;
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
        const AddArticleCustomButtonWidget(),
        const SizedBox(
          height: 10,
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
