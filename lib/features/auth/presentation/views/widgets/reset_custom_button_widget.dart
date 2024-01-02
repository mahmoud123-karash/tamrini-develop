import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class ResetCustomButtonWidget extends StatelessWidget {
  const ResetCustomButtonWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        maximumSize: const Size(170.0, 90.0),
        minimumSize: const Size(170.0, 60.0),
        backgroundColor: Colors.grey[700],
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).reset,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
          const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
