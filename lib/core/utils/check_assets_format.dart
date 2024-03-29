import 'package:tamrini/core/utils/regex.dart';

String checkImageformat(List<String> assets) {
  String image = '';
  if (assets.isEmpty) {
    return image;
  } else {
    for (int i = 0; assets.length > i; i++) {
      if (assets[i].contains(
        RegExp(
            "[^\\s]+(.*?)\\.(jpg|jpeg|png|JPG|JPEG|PNG|WEBP|webp|tiff|Tiff|TIFF|GIF|gif|bmp|BMP|svg|SVG)"),
      )) {
        image = assets[i];
      }
    }
    return image;
  }
}

String checkVedioformat(List<String> assets) {
  String vedio = '';
  if (assets.isEmpty) {
    return vedio;
  } else {
    for (int i = 0; assets.length > i; i++) {
      if (RegExp(RegexPatterns.allowedYoutubeUrlFormat).hasMatch(
        assets[i],
      )) {
        vedio = assets[i];
      }
    }
    return vedio;
  }
}
