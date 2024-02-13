import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';
import 'package:tamrini/generated/l10n.dart';

class FollowDetailsScreen extends StatelessWidget {
  const FollowDetailsScreen({super.key, required this.model});
  final FollowUpModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).follow_details),
    );
  }
}
