import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_states.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/supplement_item_widget.dart';

import 'add_supplement_row_buttons_widget.dart';

class AddSupplementWidget extends StatelessWidget {
  const AddSupplementWidget({super.key, required this.model});
  final TraineeModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseStates>(
      builder: (context, state) {
        List<String> list = CourseCubit.get(context).supplements;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SizedBox(
            height: list.isEmpty ? 0 : 350,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SupplementItemWidget(
                      supplementId: list[index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: list.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (list.isNotEmpty)
                  AddSupplementRowButtonsWidget(
                      supplememnts: list, model: model),
              ],
            ),
          ),
        );
      },
    );
  }
}
