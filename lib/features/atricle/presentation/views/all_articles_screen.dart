import 'package:flutter/material.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/aricles_item_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

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
  int sLength = 10;

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
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
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
                setState(() {});
              },
            ),
            const SizedBox(
              height: 15,
            ),
            widget.models.isNotEmpty
                ? ListView.separated(
                    itemCount: searchController.text != ''
                        ? searchList.length < sLength
                            ? searchList.length
                            : sLength + 1
                        : widget.models.length < length
                            ? widget.models.length
                            : length + 1,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index < length) {
                        return AtricleItemWidget(
                          width: getWidht,
                          model: searchController.text != ''
                              ? searchList[index]
                              : widget.models[index],
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
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
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
