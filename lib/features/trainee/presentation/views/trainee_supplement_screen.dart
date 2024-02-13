import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/presentation/views/supplement_category_screen.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/add_supplement_widget.dart';
import 'widgets/trainee_supplement_list_view_widget.dart';

class TraineeSupplementsScreen extends StatelessWidget {
  const TraineeSupplementsScreen({super.key, required this.traineeId});
  final String traineeId;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return Scaffold(
      appBar: myAppBar(S.of(context).nuttritions),
      body: BlocBuilder<TraineeCubit, TraineeStates>(
        builder: (context, state) {
          TraineeModel model =
              TraineeCubit.get(context).getTrainee(id: traineeId);
          List<String> supplements = model.supplements;
          return ListView(
            children: [
              if (userType == 'trainer')
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: addCustomButton(
                    fontSize: 15,
                    onPressed: () {
                      navigateTo(context,
                          const SupplementsCategoryScreen(isCourse: true));
                    },
                    lable: S.of(context).add_new_supplement,
                  ),
                ),
              AddSupplementWidget(model: model),
              SupplementListViewWidget(list: supplements),
            ],
          );
        },
      ),
    );
  }
}
