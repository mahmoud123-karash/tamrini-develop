import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/home/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_product_item_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

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
  int sLength = 10;

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
        setState(() {});
      }
      if (searchList.length > length) {
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
    final getWidth = mediaQuery.size.width;
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
                  SearchTextFieldWidget(
                    controller: searchController,
                    onChanged: (value) {
                      searchList = searchProduct(value, widget.list);
                      setState(() {});
                    },
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < length) {
                        return HomeProductItemWidget(
                          model: searchController.text == ''
                              ? widget.list[index]
                              : searchList[index],
                          width: getWidth,
                          smodel: StoreCubit.get(context).getStore(
                            searchController.text == ''
                                ? widget.list[index].ownerUid
                                : searchList[index].ownerUid,
                          ),
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
                    itemCount: searchController.text == ''
                        ? widget.list.length < length
                            ? widget.list.length
                            : length + 1
                        : searchList.length < sLength
                            ? searchList.length
                            : sLength + 1,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5.h,
                      );
                    },
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
