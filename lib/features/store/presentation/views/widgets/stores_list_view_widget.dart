import 'package:flutter/material.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_item_widget.dart';

class StoreListViewWidget extends StatelessWidget {
  const StoreListViewWidget({super.key, required this.list});
  final List<StoreModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => StoreItemWidget(model: list[index]),
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: list.length,
    );
  }
}
