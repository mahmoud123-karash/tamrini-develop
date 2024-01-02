import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/Upload_Image_provider.dart';
import 'package:tamrini/provider/home_provider.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/Upload%20Image.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  bool isAdding = false;

  String? bannerUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar('البانر'),
      body: Consumer<HomeProvider>(builder: (context, _, child) {
        return _.isLoading
            ? Center(
                child: Image.asset('assets/images/loading.gif',
                    height: 100.h, width: 100.w),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: kSecondaryColor,
                          onPressed: () {
                            setState(() {
                              isAdding = !isAdding;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.add_circle,
                                      color: Colors.white),
                                ),
                                Text(
                                  "إضافة بانر جديد",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 20),
                      isAdding
                          ? Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'الرابط',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    bannerUrl = value;
                                  },
                                ),
                                const SizedBox(height: 20),
                                const ImageUploads(
                                  isOneImage: true,
                                  isVideo: false,
                                ),
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: kSecondaryColor,
                                    onPressed: () async {
                                      showLoaderDialog(context);
                                      var images =
                                          await Provider.of<UploadProvider>(
                                                  context,
                                                  listen: false)
                                              .uploadFiles();
                                      var data = {
                                        'image': images[0].toString(),
                                        'url': bannerUrl!.removeAllWhitespace ??
                                            "",
                                      };
                                      bannerUrl = "";
                                      _.addBanner(data);
                                      allPhotos = [];
                                      pop();
                                      setState(() {
                                        isAdding = false;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.add_circle,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "إضافة",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ],
                            )
                          : Container(),
                      _.banners.isEmpty
                          ? const Center(
                              child: Text('لا يوجد بانرات'),
                            )
                          : ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // const SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Text(
                                                _.banners[index]['url']
                                                    .toString()
                                                    .removeAllWhitespace,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 200,
                                              height: 100,
                                              child: Image(
                                                image: FirebaseImageProvider(
                                                  FirebaseUrl(
                                                    _.banners[index]["image"]!,
                                                  ),
                                                ),
                                                // fit: BoxFit.contain,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // const Spacer(),

                                      IconButton(
                                          onPressed: () {
                                            Widget cancelButton = TextButton(
                                              child: const Text("إلغاء"),
                                              onPressed: () {
                                                pop();
                                              },
                                            );
                                            Widget continueButton = TextButton(
                                              child: const Text(
                                                "تأكيد الحذف",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                pop();

                                                _.deleteBanner(
                                                    banner: _.banners[index]);
                                              },
                                            );

                                            showDialog(
                                                context: navigationKey
                                                    .currentState!.context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: const Text(
                                                        'تأكيد الحذف',
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                      content: const Text(
                                                        'هل انت متأكد من حذف هذا البانر ؟',
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                      actions: [
                                                        continueButton,
                                                        cancelButton,
                                                      ],
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                    ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                              itemCount: _.banners.length),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
