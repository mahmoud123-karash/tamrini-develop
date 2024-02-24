import 'package:flutter/material.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'product_list_view_widget.dart';

class CategoryContentWidget extends StatefulWidget {
  const CategoryContentWidget({super.key, required this.list});
  final List<ProductModel> list;

  @override
  State<CategoryContentWidget> createState() => _CategoryContentWidgetState();
}

class _CategoryContentWidgetState extends State<CategoryContentWidget> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<ProductModel> searchList = [];

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
        Future.delayed(const Duration(seconds: 1)).then(
          (value) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setState(() {}));
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
    return Column(
      children: [
        searchField(
          controller: searchController,
          onChanged: (value) {
            searchList = searchProduct(value, widget.list);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: ProductListViewWidget(
            scrollController: scrollController,
            list: searchController.text == '' ? widget.list : searchList,
            length: length,
          ),
        ),
        if (searchController.text != '' && searchList.isEmpty)
          Expanded(
            child: Text(S.of(context).noProduct),
          ),
      ],
    );
  }
}
