import 'package:flutter/widgets.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/features/profits/presentation/views/widgets/request_item_widget.dart';

class RequestListViewWidget extends StatelessWidget {
  const RequestListViewWidget({super.key, required this.list});
  final List<ProfitsModel> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        itemBuilder: (context, index) => RequestItemWidget(
          model: list[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: 20,
      ),
    );
  }
}
