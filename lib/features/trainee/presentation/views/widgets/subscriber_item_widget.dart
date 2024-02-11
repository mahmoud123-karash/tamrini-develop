import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/writer_row_widget.dart';

class SubscriberItemWidget extends StatelessWidget {
  const SubscriberItemWidget({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appColor.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WriterRowWidget(
              model: model,
            ),
          ),
        ),
      ),
    );
  }
}