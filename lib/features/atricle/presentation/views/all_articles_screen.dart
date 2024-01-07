import 'package:flutter/material.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/article_list_view_widget.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({super.key, required this.models});
  final List<ArticleModel> models;

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
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
      if (widget.models.length > length) {
        length += 10;
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
        title: Text(S.of(context).articlesT),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SearchTextFieldWidget(
              controller: searchController,
              onChanged: (value) {
                searchList = searchArticles(value, widget.models);
                if (value == '') {
                  length = 10;
                }
                setState(() {});
              },
            ),
            const SizedBox(
              height: 15,
            ),
            widget.models.isNotEmpty
                ? ArticleListViewWidget(
                    list: searchController.text == ''
                        ? widget.models
                        : searchList,
                    length: length,
                  )
                : Center(
                    child: Text(
                      S.of(context).emptyList,
                    ),
                  ),
            if (searchList.isEmpty && searchController.text != '')
              Text(
                S.of(context).noArticles,
                style: TextStyles.style20,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
