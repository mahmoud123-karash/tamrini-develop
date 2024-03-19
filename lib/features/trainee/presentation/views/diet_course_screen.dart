import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/food_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/features/trainee/presentation/views/new_diet_course_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/diet_course_item_widget.dart';

class DietCourseScreen extends StatelessWidget {
  const DietCourseScreen(
      {super.key, required this.traineeId, this.list, required this.logo});
  final String traineeId;
  final List<FoodModel>? list;
  final String logo;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Scaffold(
      appBar: myAppBar(S.of(context).diet),
      body: BlocBuilder<TraineeCubit, TraineeStates>(
        builder: (context, state) {
          TraineeModel? model = list != null
              ? null
              : TraineeCubit.get(context).getTrainee(id: traineeId);
          List<FoodModel> food = list ?? model!.food;
          food.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return Column(
            children: [
              if (userType == UserType.trainer)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: addCustomButton(
                    fontSize: 15,
                    onPressed: () {
                      navigateTo(
                        context,
                        NewDietCourseScreen(
                          model: model!,
                          logo: logo,
                        ),
                      );
                    },
                    lable: S.of(context).add_new_diet_course,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              if (userType != UserType.trainer)
                CirclarImageWidget(image: logo, radius: 50),
              if (userType != UserType.trainer)
                const SizedBox(
                  height: 15,
                ),
              Expanded(
                child: food.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context).no_results,
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => DietCourseItemWidget(
                          model: model,
                          food: food[index],
                          logo: logo,
                        ),
                        itemCount: food.length,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
