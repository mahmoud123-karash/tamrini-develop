import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:tamrini/core/utils/regex.dart';
import 'package:tamrini/core/utils/video_manager.dart';
import 'package:tamrini/core/utils/youtube_manager.dart';

List<Widget> distributeAssets(
  List<String> assets, {
  BoxFit fit = BoxFit.cover,
  Widget? player,
}) {
  List<Widget> distributedAssets = [];
  for (int i = 0; assets.length > i; i++) {
    if (RegExp(RegexPatterns.allowedYoutubeUrlFormat).hasMatch(assets[i]) ==
        true) {
      distributedAssets.add(player ?? YoutubeManager(youtubeUrl: assets[i]));
    } else if (!assets[i].contains(RegExp(
        "[^\\s]+(.*?)\\.(jpg|jpeg|png|JPG|JPEG|PNG|WEBP|webp|tiff|Tiff|TIFF|GIF|gif|bmp|BMP|svg|SVG)"))) {
      distributedAssets.add(VideoManager(remote_url: assets[i]));
    } else {
      distributedAssets.add(
        Image(
          image: FirebaseImageProvider(
            FirebaseUrl(assets[i]),
          ),
          fit: fit,
        ),
      );
    }
  }
  return distributedAssets;
}
