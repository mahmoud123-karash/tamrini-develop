import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';

import '../day_screen.dart';

class MyDayItemWidget extends StatelessWidget {
  const MyDayItemWidget({super.key, required this.model});
  final DayModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        navigateTo(context, DayScreen(model: model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color: appColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Assets.imagesDay,
                  color: appColor,
                ),
              ),
              title: Text(
                DateFormat('EEEE, MMM d, yyyy').format(
                  model.date.toDate(),
                ),
                style: TextStyles.style16Bold,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: appColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
