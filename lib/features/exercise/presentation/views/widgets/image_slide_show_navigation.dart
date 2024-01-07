import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/utils/regex.dart';

class ImageSlideShowNavigation extends StatelessWidget {
  final List<String> assets;
  final int currentIndex;
  final void Function(int) onSliderChanged;

  const ImageSlideShowNavigation(
      {required this.assets,
      required this.currentIndex,
      required this.onSliderChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: appColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...assets
                .map(
                  (asset) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        onSliderChanged(assets.indexOf(asset));
                      },
                      child: Icon(
                        asset.contains(
                          RegExp(RegexPatterns.allowedImageFormat),
                        )
                            ? Ionicons.image_outline
                            : Ionicons.videocam,
                        color: currentIndex == assets.indexOf(asset)
                            ? appColor
                            : const Color.fromRGBO(192, 194, 194, 0.9),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
