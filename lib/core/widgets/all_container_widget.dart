import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllContainerWidget extends StatefulWidget {
  const AllContainerWidget({
    super.key,
    required this.onPressed,
    required this.image,
    required this.lable,
  });
  final VoidCallback onPressed;
  final String image, lable;

  @override
  State<AllContainerWidget> createState() => _AllContainerWidgetState();
}

class _AllContainerWidgetState extends State<AllContainerWidget> {
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
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 100.h,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.lable,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
