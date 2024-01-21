import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/may_day_list_view_builder_widget.dart';

class MyDayScreen extends StatelessWidget {
  const MyDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: appColor,
        label: Text(S.of(context).add_today),
        onPressed: () {
          addToday(context);
        },
        icon: const Icon(Icons.add),
      ),
      appBar: myAppBar(S.of(context).my_day),
      body: const MyDayListViewBuilderWidget(),
    );
  }

  void addToday(BuildContext context) {
    var box = Hive.box<DayModel>(dayBox);
    bool isCreated = box.values.toList().any((element) =>
        DateFormat.yMMMEd().format(element.date.toDate()) ==
        DateFormat.yMMMEd().format(Timestamp.now().toDate()));
    if (!isCreated) {
      DayCubit.get(context).addToday();
    } else {
      showSnackBar(context, S.of(context).add_today_hint);
    }
  }
}
