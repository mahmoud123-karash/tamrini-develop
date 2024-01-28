import 'package:flutter/material.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../store/presentation/views/widgets/store_item_widget.dart';
import 'name_text_widget.dart';

class StoreOwnerProfileWidget extends StatelessWidget {
  const StoreOwnerProfileWidget({super.key, required this.list});
  final List<StoreModel> list;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: NameTextWidget(text: S.of(context).store),
              ),
              StoreItemWidget(model: list.first),
              const SizedBox(
                height: 20,
              ),
            ],
          );
  }
}
