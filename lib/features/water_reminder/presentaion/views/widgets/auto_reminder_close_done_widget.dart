import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class AutoReminderCloseDoneWidget extends StatelessWidget {
  const AutoReminderCloseDoneWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.done),
          ),
          const Spacer(),
          Text(
            S.of(context).auto_reminder,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
