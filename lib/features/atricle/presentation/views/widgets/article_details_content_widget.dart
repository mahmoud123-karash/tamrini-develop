import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/user_builder_widget.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../home/presentation/views/widgets/image_view_widget.dart';

class ArticleDetailsContentWidget extends StatelessWidget {
  const ArticleDetailsContentWidget({super.key, required this.model});
  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (model.writerUid == uid && model.isRefused == true)
                  banWidget(lable: S.of(context).ban_food_hint),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    model.title ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: Intl.getCurrentLocale() == 'en'
                        ? TextAlign.end
                        : TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (model.image != null || model.image!.isNotEmpty)
                  ImageViewWidget(
                    image: model.image!.first,
                    width: getWidht,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      """${(model.body)}""",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (model.writerUid != uid)
                  WriterWidget(uid: model.writerUid ?? '')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WriterWidget extends StatelessWidget {
  const WriterWidget({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(
          height: 5,
        ),
        UserBuilderWidget(
          uid: uid,
        ),
      ],
    );
  }
}
