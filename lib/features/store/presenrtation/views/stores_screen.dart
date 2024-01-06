import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/store_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'search_product_screen.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key, required this.stores});
  final List<StoreModel> stores;

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
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
      if (widget.stores.length > length) {
        length += 10;
        setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).stores),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              List<ProductModel> list = [];
              for (var element in widget.stores) {
                list.addAll(element.products!);
              }
              if (list.isNotEmpty) {
                navigateTo(context, SearchProductScreen(list: list));
              }
            },
            icon: const Icon(Ionicons.search_outline),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ListView.separated(
          itemBuilder: (context, index) =>
              StoreItemWidget(model: widget.stores[index]),
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          itemCount:
              widget.stores.length < length ? widget.stores.length : length,
        ),
      ),
    );
  }
}
