import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class NoGymMessageWidget extends StatelessWidget {
  const NoGymMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.of(context).gym_remove_hint),
    );
  }
}
