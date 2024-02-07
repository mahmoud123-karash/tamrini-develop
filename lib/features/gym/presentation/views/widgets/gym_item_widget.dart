import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/gym_details_screen.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/remove_icon_gym_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/image_view_widget.dart';

import '../../../../gym/presentation/views/widgets/gym_distance_price_widget.dart';

class GymItemWidget extends StatelessWidget {
  const GymItemWidget({
    super.key,
    required this.model,
    required this.width,
    this.isHome = false,
  });
  final GymModel model;
  final double width;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          navigateTo(context, GymDetailsScreen(gymId: model.id));
        },
        child: Stack(
          children: [
            ImageViewWidget(
              image: model.assets.first,
              width: width,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: getHeight * 0.18,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[500],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueGrey[500]!.withOpacity(0.0),
                      Colors.blueGrey[500]!.withOpacity(0.5),
                      Colors.blueGrey[500]!.withOpacity(0.8),
                      Colors.blueGrey[500]!.withOpacity(1.0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
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
                          model.name,
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
                      GymDistancePriceWidget(
                        distance: model.distance,
                        price: model.price.toDouble(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (!isHome)
              if (model.ownerUid == adminUid) RemoveiconGymWidget(model: model),
          ],
        ),
      ),
    );
  }
}
