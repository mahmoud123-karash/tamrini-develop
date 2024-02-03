import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_owner_name_type_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_time_and_date_widget.dart';

class NameAswertypeUserWidget extends StatelessWidget {
  const NameAswertypeUserWidget(
      {super.key,
      required this.name,
      required this.type,
      required this.answer,
      required this.date,
      required this.time});
  final String name, type, answer, date, time;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionOwnerNameTypeWidgt(name: name, role: type),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.2),
          ),
          constraints: BoxConstraints(maxWidth: width - (60 + 40 + 20 + 20)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              answer,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w300,
                letterSpacing: -0.90,
              ),
              textAlign: TextAlign.start,
              maxLines: null,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        QuestionTimeAndDateWidget(date: date, time: time),
      ],
    );
  }
}
