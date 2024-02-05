import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/exercise_details_body_widget.dart';

class DetailsWithoutVedioScreen extends StatelessWidget {
  const DetailsWithoutVedioScreen({
    Key? key,
    this.isHome = false,
    required this.id,
    this.isAll = false,
  }) : super(key: key);
  final bool isHome, isAll;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).exDetails,
      ),
      body: ExerciseDetailsBodyWidget(
        id: id,
        isHome: isHome,
        isAll: isAll,
      ),
    );
  }
}
