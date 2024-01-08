import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tamrini/features/atricle/presentation/views/widgets/article_writer_widget.dart';
import 'package:tamrini/features/questions/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/diet_food_slide_image_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class DietFoodDetailsScreen extends StatelessWidget {
  const DietFoodDetailsScreen({super.key, required this.model});
  final DietFoodModel model;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).arDetails),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            model.title,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      model.date != Timestamp.now()
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                              child: Text(
                                intl.DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(
                                    model.date.toDate().toString(),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  model.assets.isEmpty
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: DietFoodSlideImageWidget(
                            images: model.assets,
                            title: model.title,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              (model.description),
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 40,
                    endIndent: 20,
                    indent: 20,
                  ),
                  ArticleWriterWidget(
                    writer: model.writer,
                    writerUid: model.writerUid,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
