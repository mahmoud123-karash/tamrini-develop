import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_cubit.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/food_diet_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import '../manager/diet_food_cubit/diet_food_states.dart';
import 'widgets/edit_custom_button_widget.dart';

class DietFoodDetailsScreen extends StatelessWidget {
  const DietFoodDetailsScreen({super.key, required this.id});
  final String id;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).arDetails),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: BlocBuilder<DietFoodCubit, DietFoodStates>(
            builder: (context, state) {
              List<DietFoodModel> list = DietFoodCubit.get(context).getfood(id);
              DietFoodModel? model = list.isEmpty ? null : list.first;
              return model == null
                  ? Center(
                      child: Text(
                        S.of(context).article_removed,
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: DietFoodContentWidget(model: model),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: EditCustomButtonWidget(model: model),
                            ),
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
