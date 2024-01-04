import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class HomeProductRatingWidget extends StatelessWidget {
  const HomeProductRatingWidget({
    super.key,
    required this.rating,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          ignoreGestures: true,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 15,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyles.style14.copyWith(
            color: Colors.amber,
          ),
        )
      ],
    );
  }
}
