import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';

class HoneBannerItemWidget extends StatelessWidget {
  const HoneBannerItemWidget({super.key, required this.model});
  final BannerModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Uri uri = Uri.parse(model.uri);
        openUri(url: uri);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FirebaseImageProvider(
              FirebaseUrl(model.image),
            ),
          ),
        ),
      ),
    );
  }
}
