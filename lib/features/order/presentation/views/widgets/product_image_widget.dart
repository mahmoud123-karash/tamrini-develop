import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          const SizedBox(
            height: 200,
          ),
          Container(
            height: 160,
            width: 160,
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
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.check,
              ),
            ),
          )
        ],
      ),
    );
  }
}
