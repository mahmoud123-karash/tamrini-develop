import 'package:flutter/material.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/product_list_view_widget.dart';

class ProductsCategoryScreen extends StatefulWidget {
  const ProductsCategoryScreen(
      {super.key, required this.list, required this.title});
  final List<ProductModel> list;
  final String title;

  @override
  State<ProductsCategoryScreen> createState() => _ProductsCategoryScreenState();
}

class _ProductsCategoryScreenState extends State<ProductsCategoryScreen> {
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
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: widget.list.isNotEmpty
          ? SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  ProductListViewWidget(
                    list:
                        searchController.text == '' ? widget.list : searchList,
                    length: length,
                  ),
                  if (searchController.text != '' && searchList.isEmpty)
                    Text(S.of(context).noProduct),
                ],
              ),
            )
          : Center(
              child: Text(S.of(context).nocProducts),
            ),
    );
  }
}
