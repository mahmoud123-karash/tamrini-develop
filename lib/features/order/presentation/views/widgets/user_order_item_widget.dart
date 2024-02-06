import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class UserOrderItemWidget extends StatelessWidget {
  const UserOrderItemWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: appColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image(
            width: 110,
            fit: BoxFit.contain,
            image: FirebaseImageProvider(
              FirebaseUrl(image),
            ),
          ),
        ),
      ),
    );
  }
}
