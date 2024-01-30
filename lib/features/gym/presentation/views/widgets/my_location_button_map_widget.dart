import 'package:flutter/material.dart';

class MyLocationButtonMapWidget extends StatelessWidget {
  const MyLocationButtonMapWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.3),
          ),
          color: Colors.white,
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.my_location, color: Colors.black),
        ),
      ),
    );
  }
}
