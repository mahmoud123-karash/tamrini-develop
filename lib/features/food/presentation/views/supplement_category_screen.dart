import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_grid_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementsCategoryScreen extends StatelessWidget {
  const SupplementsCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).nuttritions),
      body: const SupplementGridViewBuilderWidget(),
    );
  }
}
