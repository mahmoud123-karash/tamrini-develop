import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';

class DietFoodNameAndDateWidget extends StatelessWidget {
  const DietFoodNameAndDateWidget(
      {super.key, required this.name, required this.date});
  final String name;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: AutoSizeText(
                name,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            date != Timestamp.now()
                ? AutoSizeText(
                    DateFormat('yyyy-MM-dd', 'en').format(
                      DateTime.parse(
                        date.toDate().toString(),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
