import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class ShowGymImagesScaffoldWidget extends StatelessWidget {
  const ShowGymImagesScaffoldWidget(
      {super.key,
      required this.assets,
      required this.name,
      required this.imgIndex});
  final List<String> assets;
  final String name;
  final int imgIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF2F7),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF003E4F),
        ),
        centerTitle: true,
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff007c9d),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ImageSlideshow(
          initialPage: imgIndex,
          height: 1.sh,
          children: List.generate(
            assets.length,
            (index) => PhotoView(
              backgroundDecoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.3,
                image: FirebaseImageProvider(
                  FirebaseUrl(
                    assets[index],
                  ),
                  options: const CacheOptions(
                    checkForMetadataChange: false,
                  ),
                ),
              )),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              imageProvider: FirebaseImageProvider(
                FirebaseUrl(
                  assets[index],
                ),
                options: const CacheOptions(
                  checkForMetadataChange: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
