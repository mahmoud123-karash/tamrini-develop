import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DietCourseDateAndNameRowWidget extends StatelessWidget {
  const DietCourseDateAndNameRowWidget(
      {super.key, required this.title, required this.createdAt});
  final String title;
  final Timestamp createdAt;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width / 2),
          child: Text(
            title,
            maxLines: 2,
          ),
        ),
        const Spacer(),
        Text(
          DateFormat('EEE, M/d/y').format(
            createdAt.toDate(),
          ),
        ),
      ],
    );
  }
}
