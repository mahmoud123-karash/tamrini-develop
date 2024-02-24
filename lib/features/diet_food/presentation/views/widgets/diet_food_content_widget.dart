import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/views/new_diet_food_screen.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class DietFoodContentWidget extends StatefulWidget {
  const DietFoodContentWidget({super.key, required this.models});
  final List<DietFoodModel> models;

  @override
  State<DietFoodContentWidget> createState() => _DietFoodContentWidgetState();
}

class _DietFoodContentWidgetState extends State<DietFoodContentWidget> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<DietFoodModel> searchList = [];

  int length = 10;

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
        Future.delayed(const Duration(seconds: 1)).then(
          (value) {
            if (mounted) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => setState(() {}));
            }
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
    String userType = CacheHelper.getData(key: 'usertype');

    return Column(
      children: [
        searchField(
          controller: searchController,
          onChanged: (value) {
            searchList = searchDietFood(value, widget.models);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        if (userType == UserType.admin || userType == UserType.writer)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: addCustomButton(
              onPressed: () {
                navigateTo(context, const NewDietFoodScreen());
              },
              lable: S.of(context).new_meal,
            ),
          ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: DietFoodListViewWidget(
            controller: scrollController,
            list: searchController.text == '' ? widget.models : searchList,
            length: length,
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
