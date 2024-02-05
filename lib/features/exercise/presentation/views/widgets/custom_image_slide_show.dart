import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'image_slide_show_navigation.dart';

class CustomImageSlideShow extends StatefulWidget {
  final List<Widget> children;
  final List<String> assets;
  final int? currentIndex;
  final void Function(int)? onPageChanged;
  final double? height;

  const CustomImageSlideShow(
      {required this.assets,
      required this.children,
      this.onPageChanged,
      this.height = 200,
      this.currentIndex,
      Key? key})
      : super(key: key);

  @override
  State<CustomImageSlideShow> createState() => _CustomImageSlideShowState();
}

class _CustomImageSlideShowState extends State<CustomImageSlideShow> {
  int _currentIndex = 0;
  bool showSlider = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex ?? 0;
  }

  void onSliderIconClicked(int index) {
    if (index != _currentIndex) {
      setState(
        () {
          showSlider = false;
          _currentIndex = index;
          Future.delayed(const Duration(milliseconds: 50)).then(
            (value) => setState(
              () {
                showSlider = true;
              },
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showSlider == true) ...[
          ImageSlideshow(
            indicatorColor: Colors.transparent,
            indicatorBackgroundColor: Colors.transparent,
            initialPage: _currentIndex,
            height: widget.height!,
            onPageChanged: (value) {
              if (widget.onPageChanged != null) {
                widget.onPageChanged!(value);
              }
              setState(() {
                _currentIndex = value;
              });
            },
            children: widget.children,
          ),
          const SizedBox(
            height: 10,
          ),
          Positioned.fill(
            bottom: 5,
            child: ImageSlideShowNavigation(
              assets: widget.assets,
              currentIndex: _currentIndex,
              onSliderChanged: onSliderIconClicked,
            ),
          )
        ]
      ],
    );
  }
}
