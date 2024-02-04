import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/presentation/views/new_supplement_screen.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_articles_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementArticlesContextWidget extends StatefulWidget {
  const SupplementArticlesContextWidget({
    Key? key,
    required this.category,
  }) : super(key: key);
  final SupplementModel category;
  @override
  State<SupplementArticlesContextWidget> createState() =>
      _SupplementArticlesContextWidgetState();
}

class _SupplementArticlesContextWidgetState
    extends State<SupplementArticlesContextWidget> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<SupplementData> searchList = [];

  int length = 10;

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.category.data.length > length) {
        length += 10;
        Future.delayed(const Duration(seconds: 1)).then(
          (value) {
            if (mounted) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => setState(() {}));
              });
            }
          },
        );
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController.addListener(_loadMoreData);
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');

    return Column(
      children: [
        searchField(
          controller: searchController,
          onChanged: (value) {
            searchList = searchSupplement(value, widget.category.data);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        if (userType == 'admin' || userType == 'writer')
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: addCustomButton(
              onPressed: () {
                navigateTo(context,
                    NewSupplementScreen(categoryId: widget.category.id ?? ''));
              },
              lable: S.of(context).add_supplement,
            ),
          ),
        Expanded(
          child: widget.category.data.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).no_results,
                  ),
                )
              : SupplementAriclesListViewWidget(
                  scrollController: scrollController,
                  length: length,
                  list: searchController.text == ''
                      ? widget.category.data
                      : searchList,
                  categoryId: widget.category.id ?? '',
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
    );
  }
}
