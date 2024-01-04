import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/store_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key, required this.stores});
  final List<StoreModel> stores;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).stores),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ListView.separated(
          itemBuilder: (context, index) =>
              StoreItemWidget(model: stores[index]),
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          itemCount: stores.length,
        ),
      ),
    );
  }
}
