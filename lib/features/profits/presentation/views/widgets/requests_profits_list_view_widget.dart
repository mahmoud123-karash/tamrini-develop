import 'package:flutter/material.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/features/profits/presentation/views/widgets/request_profits_item_widget.dart';

class RequestsProfitsListViewWidget extends StatelessWidget {
  const RequestsProfitsListViewWidget({super.key, required this.list});
  final List<ProfitsModel> list;
  @override
  Widget build(BuildContext context) {
    list.sort(
      (a, b) => b.requestedAt.compareTo(a.requestedAt),
    );
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => RequestProfitsItemWidget(
        model: list[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: list.length,
    );
  }
}
