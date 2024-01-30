import 'package:flutter/material.dart';

class MapNavigateButtonWidget extends StatelessWidget {
  const MapNavigateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.3),
          ),
          color: Colors.white,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.check, color: Colors.black),
        ),
      ),
    );
  }
}
