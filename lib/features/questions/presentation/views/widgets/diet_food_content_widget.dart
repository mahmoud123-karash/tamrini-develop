import 'package:flutter/material.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/features/questions/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/diet_food_list_view_widget.dart';
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
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SearchTextFieldWidget(
            controller: searchController,
            onChanged: (value) {
              searchList = searchDietFood(value, widget.models);
              if (value == '') {
                length = 10;
              }
              setState(() {});
            },
          ),
          const SizedBox(
            height: 15,
          ),
          DietFoodListViewWidget(
            list: searchController.text == '' ? widget.models : searchList,
            length: length,
          ),
          if (searchList.isEmpty && searchController.text != '')
            Text(
              S.of(context).noArticles,
              style: TextStyles.style20,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
