import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({
    super.key,
    required this.onPressed,
    required this.image,
    required this.lable,
  });
  final VoidCallback onPressed;
  final String image, lable;

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  late Image image;
  @override
  void initState() {
    image = Image.asset(
      widget.image,
      fit: BoxFit.cover,
      height: 100.h,
      cacheHeight: 500,
      width: double.infinity,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Stack(
          children: [
            image,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.lable,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
