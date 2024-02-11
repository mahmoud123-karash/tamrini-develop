import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_image_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../trainer_profile_screen.dart';

class TrainerItemWidget extends StatelessWidget {
  const TrainerItemWidget({super.key, required this.model});
  final TrainerModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: getHeight * 0.3,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            navigateTo(context, TrainerProfileScreen(id: model.uid));
          },
          child: Stack(
            children: [
              TarinerImageWidget(image: model.user!.image),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[500],
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueGrey[900]!.withOpacity(0.0),
                        Colors.blueGrey[500]!.withOpacity(0.5),
                        Colors.blueGrey[500]!.withOpacity(0.8),
                        Colors.blueGrey[500]!.withOpacity(1.0),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 5,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: SafeArea(
                    minimum: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.user!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          model.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 15.sp,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${model.traineesCount} ${S.of(context).trainee} ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              " ${model.price} ${S.of(context).currency}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
