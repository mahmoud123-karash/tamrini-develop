import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/name_type_answer_user_widget.dart';

class AnswerItemWidgt extends StatelessWidget {
  const AnswerItemWidgt({
    super.key,
    required this.model,
    required this.name,
    required this.image,
    required this.type,
  });

  final AnswerModel model;
  final String name, image, type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 25,
              backgroundImage: image != ''
                  ? FirebaseImageProvider(
                      FirebaseUrl(''),
                    ) as ImageProvider
                  : const AssetImage(
                      Assets.imagesProfile,
                    ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          NameAswertypeUserWidget(
            name: name,
            type: type,
            answer: model.answer,
            date: DateFormat('MM/dd/yy', 'en').format(model.date.toDate()),
            time: DateFormat('h:mm a', 'en').format(model.date.toDate()),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
