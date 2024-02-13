import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_article_item_widget.dart';

class SupplementListViewWidget extends StatelessWidget {
  const SupplementListViewWidget({super.key, required this.list});
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplementCubit, SupplementStates>(
      builder: (context, state) {
        if (state is SucessGetSupplementState) {
          List<SupplementData> finalList = [];
          for (var element in list) {
            SupplementData? model =
                SupplementCubit.get(context).getSupplementData(element);
            if (model != null) {
              finalList.add(model);
            }
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => SupplementArticleItemWidget(
              model: finalList[index],
              categoryId: '',
              isCourse: false,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 0,
            ),
            itemCount: finalList.length,
          );
        } else if (state is ErrorGetSupplementState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                state.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
