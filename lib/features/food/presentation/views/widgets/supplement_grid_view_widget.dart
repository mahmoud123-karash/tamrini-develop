import 'package:flutter/material.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_category_item_widget.dart';

class SupplementGridViewWidget extends StatelessWidget {
  const SupplementGridViewWidget({super.key, required this.list});
  final List<SupplementModel> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20,
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return SupplementCategoryItemWidget(
              model: list[index],
            );
          },
        ),
      ),
    );
  }
}
