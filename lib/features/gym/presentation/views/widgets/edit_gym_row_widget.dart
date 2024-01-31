import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/views/new_gym_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class EditGymRowWidget extends StatelessWidget {
  const EditGymRowWidget({super.key, required this.model});
  final GymModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: appColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.edit,
                color: whiteColor,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: customButton(
              onPressed: () {
                navigateTo(context, NewGymScreen(model: model));
              },
              lable: S.of(context).edit,
            ),
          ),
        ],
      ),
    );
  }
}
