import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/home/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_product_item_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key, required this.list});
  final List<ProductModel> list;

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
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
        setState(() {});
      }

      if (searchController.text == '') {
        length = 10;
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
        title: Text(S.of(context).search),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
            if (searchController.text != '')
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index < length) {
                    return HomeProductItemWidget(
                      model: searchList[index],
                      width: getWidth,
                      smodel: StoreCubit.get(context).getStore(
                        searchList[index].ownerUid,
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
                itemCount:
                    searchList.length < length ? searchList.length : length + 1,
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
      ),
    );
  }
}
