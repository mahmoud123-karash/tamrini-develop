import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

import '../new_article_screen.dart';

class AddArticleCustomButtonWidget extends StatelessWidget {
  const AddArticleCustomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: appColor,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      onPressed: () {
        navigateTo(context, const NewArticleScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_sharp,
            color: whiteColor,
            size: 18,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            S.of(context).add_article,
            style: TextStyles.style13.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
