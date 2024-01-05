import 'package:flutter/material.dart';

class NewBadgeWidget extends StatelessWidget {
  const NewBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.all(3.0),
        child: Text(
          'new',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
