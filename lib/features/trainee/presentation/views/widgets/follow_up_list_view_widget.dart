import 'package:flutter/material.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/follow_up_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class FollowUpListViewWidget extends StatelessWidget {
  const FollowUpListViewWidget(
      {super.key, required this.list, required this.themeColor});
  final List<FollowUpModel> list;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return Expanded(
      child: list.isEmpty
          ? Center(
              child: Text(S.of(context).no_results),
            )
          : ListView.separated(
              itemBuilder: (context, index) => FollowUpItemWidget(
                model: list[index],
                themeColor: themeColor,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemCount: list.length,
            ),
    );
  }
}
