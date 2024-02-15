import 'package:flutter/material.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/writer_row_widget.dart';

class UsersListViewWidget extends StatelessWidget {
  const UsersListViewWidget(
      {super.key,
      required this.list,
      required this.length,
      required this.controller,});
  final List<UserModel> list;
  final int length;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        controller: controller,
        itemBuilder: (context, index) {
          if (index < length) {
            return WriterRowWidget(model: list[index]);
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        separatorBuilder: (context, index) => const Divider(
          height: 30,
        ),
        itemCount: list.length <= length ? list.length : length + 1,
      ),
    );
  }
}
