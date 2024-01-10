import 'package:flutter/material.dart';

class AddQuestionBottomSheetWidget extends StatelessWidget {
  const AddQuestionBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
