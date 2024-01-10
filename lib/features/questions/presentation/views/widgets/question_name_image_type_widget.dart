// ignore_for_file: file_names

import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_owner_name_type_widget.dart';

class QuestionOwnerNameImageTypeWidget extends StatelessWidget {
  const QuestionOwnerNameImageTypeWidget({
    super.key,
    required this.image,
    required this.name,
    required this.type,
    required this.uid,
  });
  final String image, name, type, uid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 30,
            backgroundImage: image != ''
                ? FirebaseImageProvider(
                    FirebaseUrl(image),
                  ) as ImageProvider
                : const AssetImage(
                    Assets.imagesProfile,
                  ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        QuestionOwnerNameTypeWidgt(
          name: name,
          role: type,
        ),
        const Spacer(),
        if (uid == CacheHelper.getData(key: 'uid'))
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {},
            child: const Icon(Icons.more_vert_sharp),
          ),
      ],
    );
  }
}
