import 'package:flutter/material.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_content_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class DietFoodScreen extends StatelessWidget {
  const DietFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).diet_food),
        centerTitle: true,
      ),
      body: const DietFoodContentBuilderWidget(),
    );
  }
}
