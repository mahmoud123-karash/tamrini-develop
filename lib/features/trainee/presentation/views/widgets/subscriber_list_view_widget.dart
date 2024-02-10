import 'package:flutter/material.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/writer_row_widget.dart';
import 'package:tamrini/features/trainee/data/models/sub_model/trainee_model.dart';

class SubscriberListViewWidget extends StatelessWidget {
  const SubscriberListViewWidget(
      {super.key,
      required this.list,
      required this.length,
      required this.controller});
  final List<TraineeModel> list;
  final int length;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      itemBuilder: (context, index) {
        if (index < length) {
          return WriterRowWidget(
            model: list[index].user!,
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: length < list.length ? length + 1 : list.length,
    );
  }
}
