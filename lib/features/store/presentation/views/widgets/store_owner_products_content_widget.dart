import 'package:flutter/material.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_store_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class StoreOnwerProductsContentWidget extends StatefulWidget {
  const StoreOnwerProductsContentWidget({super.key, required this.model});
  final StoreModel model;

  @override
  State<StoreOnwerProductsContentWidget> createState() =>
      _StoreOnwerProductsContentWidgetState();
}

class _StoreOnwerProductsContentWidgetState
    extends State<StoreOnwerProductsContentWidget> {
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
      if (widget.model.products!.length > length) {
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
            searchList = searchProduct(value, widget.model.products ?? []);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        widget.model.products!.isEmpty
            ? Expanded(
                child: Text(
                  S.of(context).no_products_yet,
                ),
              )
            : ProductListViewWidget(
                list: searchController.text != ''
                    ? searchList
                    : widget.model.products ?? [],
                length: length,
                model: widget.model,
                controller: scrollController,
              ),
        if (searchController.text != '' && searchList.isEmpty)
          Expanded(
            child: Text(
              S.of(context).no_results,
            ),
          )
      ],
    );
  }
}

class ProductListViewWidget extends StatelessWidget {
  const ProductListViewWidget(
      {super.key,
      required this.list,
      required this.length,
      required this.model,
      required this.controller});
  final List<ProductModel> list;
  final int length;
  final StoreModel model;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: ListView.separated(
          controller: controller,
          itemBuilder: (context, index) {
            if (index < length) {
              return ProductStoreItemWidget(
                model: list[index],
                sModel: model,
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
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: list.length <= length ? list.length : length + 1,
        ),
      ),
    );
  }
}
