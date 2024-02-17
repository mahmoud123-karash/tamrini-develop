import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';
import 'package:tamrini/features/banner/presentation/views/widgets/remove_icon_button_wodget.dart';

class BannerItemWidget extends StatelessWidget {
  const BannerItemWidget({super.key, required this.model});
  final BannerModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Uri uri = Uri.parse(model.uri);
        openUri(url: uri);
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: 190,
            width: double.infinity,
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
          RemoveiconButtonWidget(model: model)
        ],
      ),
    );
  }
}
