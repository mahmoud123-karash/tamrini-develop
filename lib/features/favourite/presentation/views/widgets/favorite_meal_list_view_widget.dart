import 'package:flutter/material.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/presentation/views/widgets/meal_item_widget.dart';

class FavoriteMealListViewWidget extends StatefulWidget {
  const FavoriteMealListViewWidget({super.key, required this.list});
  final List<MealModel> list;

  @override
  State<FavoriteMealListViewWidget> createState() =>
      _FavoriteMealListViewWidgetState();
}

class _FavoriteMealListViewWidgetState
    extends State<FavoriteMealListViewWidget> {
  ScrollController scrollController = ScrollController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index < length) {
            return MealItemWidget(
              model: widget.list[index],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount:
            length >= widget.list.length ? widget.list.length : length + 1,
      ),
    );
  }
}
