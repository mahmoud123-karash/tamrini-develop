import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class SuggestImageWIdget extends StatelessWidget {
  const SuggestImageWIdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '(${S.of(context).optional})',
          style: TextStyles.style14.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        addFromGalleryItems(
          title: S.of(context).add_image,
          icon: Icons.add_a_photo_outlined,
          function: () {
            ImageCubit.get(context).pickImage();
          },
        ),
      ],
    );
  }
}
