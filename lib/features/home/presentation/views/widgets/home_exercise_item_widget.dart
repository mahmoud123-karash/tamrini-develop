import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_without_vedio_screen.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_image_widget.dart';

class HomeExerciseItemWidget extends StatelessWidget {
  const HomeExerciseItemWidget({super.key, required this.model});
  final DataModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () async {
          if (model.assets != null || model.assets!.isNotEmpty) {
            if (model.assets!.length == 2) {
              navigateTo(context,
                  DetailsScreen(model: model, vedio: model.assets![1]));
            }
            if (model.assets!.length == 1 &&
                checkVedioformat(model.assets!) != '') {
              navigateTo(context,
                  DetailsScreen(model: model, vedio: model.assets!.first));
            }
            if (model.assets!.length == 1 &&
                checkVedioformat(model.assets!) == '') {
              navigateTo(context, DetailsWithoutVedioScreen(model: model));
            }
          } else {
            navigateTo(context, DetailsWithoutVedioScreen(model: model));
          }
        },
        child: Stack(
          children: [
            if (model.assets != null || model.assets!.isNotEmpty)
              model.assets!.length == 2
                  ? HomeImageWidget(
                      width: getWidht - 70, image: model.assets!.first)
                  : HomeImageWidget(
                      width: getWidht - 70,
                      image: checkVedioformat(model.assets!) == ''
                          ? model.assets!.first
                          : '',
                    ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: getHeight * 0.18,
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          model.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        model.description!,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
