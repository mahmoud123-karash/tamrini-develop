import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamrini/model/article.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/Articles_screens/edit_article_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/video_manager.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../../utils/distripute_assets.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final Article article;
  final String? type;
  final bool? isAll;
  const ArticleDetailsScreen(
      {super.key,
      required this.article,
      required this.type,
      required this.isAll});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  VideoManager? videoManager;
  int imgIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> assets = [];
    if (widget.article.image != null) {
      assets = distributeAssets(widget.article.image! as List<String>);
    }
    return Scaffold(
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("تفاصيل المقال"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            // constraints:  BoxConstraints(
            //   minHeight: MediaQuery.of(context).size.height,
            // ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            widget.article.title ?? '',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                widget.article.date!.toDate().toString())),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                // fontSize: 15.sp,
                                // fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget.article.image == null || widget.article.image!.isEmpty
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: ImageSlideshow(
                            onPageChanged: (value) {
                              imgIndex = value;
                            },
                            // options: CarouselOptions(
                            //   height: 200.h,
                            //   viewportFraction: 1,
                            //   initialPage: 0,
                            //   enableInfiniteScroll: true,
                            //   reverse: false,
                            //   autoPlay: true,
                            //   autoPlayInterval: const Duration(seconds: 5),
                            //   autoPlayAnimationDuration:
                            //       const Duration(milliseconds: 800),
                            //   autoPlayCurve: Curves.fastOutSlowIn,
                            //   enlargeCenterPage: true,
                            //   scrollDirection: Axis.horizontal,
                            // ),
                            children: [
                              for (var i = 0;
                                  i < widget.article.image!.length;
                                  i++)
                                InkWell(
                                  onTap: () {
                                    if (widget.article.image![i].contains(RegExp(
                                        "[^\\s]+(.*?)\\.(jpg|jpeg|png|JPG|JPEG|PNG|WEBP|webp|tiff|Tiff|TIFF|GIF|gif|bmp|BMP|svg|SVG)"))) {
                                      showDialog<dynamic>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return OrientationBuilder(
                                              builder: (context, orientation) {
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return Scaffold(
                                                    appBar: AppBar(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFFEFF2F7),
                                                      elevation: 0,
                                                      iconTheme:
                                                          const IconThemeData(
                                                              color: Color(
                                                                  0xFF003E4F)),
                                                      centerTitle: false,
                                                      title: Text(
                                                        widget.article.title ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: const Color(
                                                              0xff007c9d),
                                                        ),
                                                      ),
                                                    ),
                                                    body: Container(
                                                      // height: 1.sh,
                                                      alignment:
                                                          Alignment.center,
                                                      child: ImageSlideshow(
                                                        initialPage: imgIndex,
                                                        height: 1.sh,
                                                        children: assets,
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                            );
                                          });
                                    }
                                  },
                                  child: assets[i],
                                )
                            ],
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
                              """${(widget.article.body)}""",
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, right: 8.0),
                                child: SizedBox(
                                  // width: double.infinity,
                                  child: Text(
                                    "بواسطة :  ${widget.article.writer}",
                                    style: TextStyle(
                                      fontSize: 20.sm,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Provider.of<UserProvider>(context, listen: false)
                                    .isAdmin &&
                                !widget.isAll!
                            ? MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                color: kSecondaryColor!,
                                onPressed: () {
                                  To(EditArticlesScreen(
                                    article: widget.article,
                                    type: widget.type,
                                  ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "تعديل",
                                      style: TextStyle(
                                          fontSize: 18.sp, color: Colors.white),
                                    ),
                                  ],
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
