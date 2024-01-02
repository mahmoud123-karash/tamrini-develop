import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tamrini/utils/regex.dart';
import 'package:tamrini/utils/video_manager.dart';
import 'package:tamrini/utils/youtube_manager.dart';

List<Widget> distributeAssets(List<String> assets) {
  List<Widget> distributedAssets = [];
  for (int i = 0; assets.length > i; i++) {
    if (RegExp(RegexPatterns.allowedYoutubeUrlFormat).hasMatch(assets[i]) ==
        true) {
      distributedAssets.add(YoutubeManager(youtubeUrl: assets[i]));
    } else if (!assets[i].contains(RegExp(
        "[^\\s]+(.*?)\\.(jpg|jpeg|png|JPG|JPEG|PNG|WEBP|webp|tiff|Tiff|TIFF|GIF|gif|bmp|BMP|svg|SVG)"))) {
      distributedAssets.add(VideoManager(remote_url: assets[i]));
    } else {
      distributedAssets.add(
        PhotoView(
          imageProvider: FirebaseImageProvider(
            FirebaseUrl(assets[i]),
          ),
        ),
      );
    }
  }
  return distributedAssets;
}
