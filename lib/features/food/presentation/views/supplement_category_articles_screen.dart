import 'package:flutter/material.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_articles_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementArticlesScreen extends StatefulWidget {
  const SupplementArticlesScreen(
      {Key? key, required this.list, required this.title})
      : super(key: key);
  final List<SupplementData> list;
  final String title;
  @override
  State<SupplementArticlesScreen> createState() =>
      _SupplementArticlesScreenState();
}

class _SupplementArticlesScreenState extends State<SupplementArticlesScreen> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<SupplementData> searchList = [];

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
    return Scaffold(
      appBar: myAppBar(widget.title),
      body: Column(
        children: [
          searchField(
            controller: searchController,
            onChanged: (value) {
              searchList = searchSupplement(value, widget.list);
              if (value == '') {
                length = 10;
              }
              setState(() {});
            },
          ),
          Expanded(
            child: SupplementAriclesListViewWidget(
              scrollController: scrollController,
              length: length,
              list: searchController.text == '' ? widget.list : searchList,
            ),
          ),
          if (searchList.isEmpty && searchController.text != '')
            Expanded(
              child: Text(
                S.of(context).no_results,
                style: TextStyles.style20,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
