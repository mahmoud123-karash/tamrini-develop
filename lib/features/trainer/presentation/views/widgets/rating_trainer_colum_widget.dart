import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/rating/presentation/manager/store_cubit/rating_cubit.dart';
import 'package:tamrini/features/rating/presentation/manager/store_cubit/rating_states.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RatingTrainerColumWidget extends StatefulWidget {
  const RatingTrainerColumWidget(
      {super.key, required this.model, required this.trainerId});
  final TraineeModel model;
  final String trainerId;

  @override
  State<RatingTrainerColumWidget> createState() =>
      _RatingTrainerColumWidgetState();
}

class _RatingTrainerColumWidgetState extends State<RatingTrainerColumWidget> {
  double rate = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(S.of(context).rating_trainer_hint),
          const SizedBox(
            height: 10,
          ),
          RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 40,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              RatingCubit.get(context).rating = rating;
              rate = rating;
              setState(() {});
            },
          ),
          const SizedBox(
            height: 10,
          ),
          if (rate > 1)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: BlocConsumer<RatingCubit, RatingStates>(
                listener: (context, state) {
                  if (state is SucessRateTrainerState) {
                    showSnackBar(context, S.of(context).thanks_for_rating);
                    UserCourseCubit.get(context).rateTrainer(
                      traineeModel: widget.model,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingRateProductState) {
                    return const CircularProgressIndicator();
                  } else {
                    return customButton(
                      onPressed: () {
                        RatingCubit.get(context).rateTrainer(
                          trainerId: widget.trainerId,
                        );
                      },
                      lable: S.of(context).rate,
                    );
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}
