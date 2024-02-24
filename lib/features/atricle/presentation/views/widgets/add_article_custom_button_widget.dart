import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/generated/l10n.dart';

import '../new_article_screen.dart';

class AddArticleCustomButtonWidget extends StatelessWidget {
  const AddArticleCustomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return userType == UserType.admin || userType == UserType.writer
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: addCustomButton(
              fontSize: 18,
              onPressed: () {
                navigateTo(context, const NewArticleScreen());
              },
              lable: S.of(context).add_article,
            ),
          )
        : Container();
  }
}
