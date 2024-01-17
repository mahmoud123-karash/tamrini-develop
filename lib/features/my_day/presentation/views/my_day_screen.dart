import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

class MyDayScreen extends StatelessWidget {
  const MyDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).my_day),
    );
  }
}
