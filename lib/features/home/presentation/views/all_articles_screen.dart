import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/aricles_item_widget.dart';
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
  List<ArticleModel> searchList = [];
  @override
  void dispose() {
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
                        ? searchList.length > 10
                            ? 10
                            : searchList.length
                        : widget.models.length > 50
                            ? 30
                            : widget.models.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Random random = Random();

                      return AtricleItemWidget(
                        width: getWidht,
                        model: searchController.text != ''
                            ? searchList[index]
                            : widget
                                .models[random.nextInt(widget.models.length)],
                      );
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
