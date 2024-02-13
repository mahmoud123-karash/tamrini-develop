import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_article_item_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'remove_supplement_icon_widget.dart';

class SupplementListViewWidget extends StatelessWidget {
  const SupplementListViewWidget({super.key, required this.model});
  final TraineeModel model;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<SupplementCubit, SupplementStates>(
      builder: (context, state) {
        if (state is SucessGetSupplementState) {
          List<SupplementData> finalList = [];
          for (var element in model.supplements) {
            SupplementData? model =
                SupplementCubit.get(context).getSupplementData(element);
            if (model != null) {
              finalList.add(model);
            }
          }
          return finalList.isEmpty
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: height - 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        S.of(context).no_results,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      SupplementArticleItemWidget(
                        model: finalList[index],
                        categoryId: '',
                        isCourse: false,
                      ),
                      RemoveSupplementIconWidget(
                        model: model,
                        supplementId: finalList[index].id,
                        name: finalList[index].title,
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 0,
                  ),
                  itemCount: finalList.length,
                );
        } else if (state is ErrorGetSupplementState) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: height - 200,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: height - 200,
              ),
              const CircularProgressIndicator(),
            ],
          );
        }
      },
    );
  }
}
