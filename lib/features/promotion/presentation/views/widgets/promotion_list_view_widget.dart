import 'package:flutter/material.dart';
import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';
import 'package:tamrini/features/promotion/presentation/views/widgets/promotion_item_widget.dart';

class PromotionListViwWidget extends StatelessWidget {
  const PromotionListViwWidget({super.key, required this.list});
  final List<PromotionModel> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.separated(
        itemBuilder: (context, index) => PromotionItemWidget(
          model: list[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: list.length,
      ),
    );
  }
}
