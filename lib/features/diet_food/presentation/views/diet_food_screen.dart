import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_cubit.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_content_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class DietFoodScreen extends StatelessWidget {
  const DietFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).diet_food),
      bottomNavigationBar: const BannerAdWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              DietFoodCubit.get(context).getData();
            },
          );
        },
        child: const DietFoodContentBuilderWidget(),
      ),
    );
  }
}
