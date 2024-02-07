import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/widgets.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/rating/presentation/views/widgets/rating_container_widget.dart';

class RatingContentWidget extends StatelessWidget {
  const RatingContentWidget(
      {super.key, required this.image, required this.name});
  final String image, name;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: width / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FirebaseImageProvider(
                  FirebaseUrl(image),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: TextStyles.style16Bold.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const RatingContainerWidget(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
