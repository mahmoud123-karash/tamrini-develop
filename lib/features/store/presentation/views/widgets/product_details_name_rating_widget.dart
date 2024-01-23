import 'package:flutter/material.dart';
import 'package:tamrini/features/home/presentation/views/widgets/new_badge_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_rating_widget.dart';

class ProductDetailsNameRatingWidget extends StatelessWidget {
  const ProductDetailsNameRatingWidget({
    super.key,
    required this.title,
    required this.rating,
  });
  final String title;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
        rating != 0
            ? ProductRatingWidget(
                rating: rating,
              )
            : const NewBadgeWidget(),
      ],
    );
  }
}
