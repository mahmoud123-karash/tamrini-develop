import 'package:flutter/material.dart';

class WarningEndSubContainerWidget extends StatelessWidget {
  const WarningEndSubContainerWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.red,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                message,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
