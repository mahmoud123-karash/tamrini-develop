import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';

class WriteAnswerWidget extends StatefulWidget {
  const WriteAnswerWidget({super.key});

  @override
  State<WriteAnswerWidget> createState() => _WriteAnswerWidgetState();
}

class _WriteAnswerWidgetState extends State<WriteAnswerWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: appColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Ionicons.send,
                    color: whiteColor,
                    size: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: controller,
                minLines: 1,
                maxLines: 15,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: appColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: appColor),
                  ),
                  hintText: S.of(context).add_answer,
                  hintStyle: TextStyle(
                    color: blackColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
