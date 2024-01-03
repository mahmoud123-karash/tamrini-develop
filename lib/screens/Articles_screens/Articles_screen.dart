import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamrini/provider/artical_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/Articles_screens/Add_article_screen.dart';
import 'package:tamrini/screens/Articles_screens/Article_details_screen.dart';
import 'package:tamrini/screens/Articles_screens/pending_articles_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  void dispose() {
    Provider.of<ArticleProvider>(navigationKey.currentContext!, listen: false)
        .clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar("المقالات"),
      persistentFooterButtons: [adBanner()],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<ArticleProvider>(
            builder: (context, articleProvider, child) {
          return articleProvider.isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Image.asset('assets/images/loading.gif',
                        height: 100.h, width: 100.w),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await articleProvider.fetchAndSetArticles();
                    await articleProvider.fetchAndSetPendingArticles();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        searchBar(
                          articleProvider.searchController,
                          (p0) => articleProvider.sortBy(),
                        ),
                        Provider.of<UserProvider>(context, listen: false)
                                    .isAdmin ||
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .isCaptain
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .isCaptain
                                            ? MainAxisAlignment.center
                                            : MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 50.h,
                                          child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              color: kSecondaryColor!,
                                              onPressed: () {
                                                To(const AddArticlesScreen());
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Icon(
                                                        Icons.add_circle,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "اضافة مقال",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .isCaptain
                                          ? const SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 50.h,
                                                child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                    color: kSecondaryColor!,
                                                    onPressed: () {
                                                      print(
                                                        "pending articles length : ${articleProvider.pendingArticles.length}  ",
                                                      );
                                                      articleProvider
                                                          .fetchAndSetPendingArticles();
                                                      To(const PendingArticlesScreen());
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0),
                                                          child: Icon(
                                                              Icons.access_time,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          "المقالات المعلقة : ${articleProvider.pendingArticles.length}",
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        articleProvider.searchController.text.isNotEmpty &&
                                articleProvider.filteredArticles.isEmpty
                            ? const Center(
                                child: Text("لا يوجد مقالات بهذا الإسم"),
                              )
                            : articleProvider.filteredArticles.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      List<Widget> assets = [];
                                      if (articleProvider
                                              .filteredArticles[index].image !=
                                          null) {
                                        assets = distributeAssets(
                                            articleProvider
                                                .filteredArticles[index]
                                                .image!);
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            To(ArticleDetailsScreen(
                                              article: articleProvider
                                                  .filteredArticles[index],
                                              type: 'existing',
                                              isAll: false,
                                            ));
                                          },
                                          child: Stack(
                                            children: [
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                elevation: 7,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      articleProvider
                                                                      .filteredArticles[
                                                                          index]
                                                                      .image ==
                                                                  null ||
                                                              articleProvider
                                                                  .filteredArticles[
                                                                      index]
                                                                  .image!
                                                                  .isEmpty
                                                          ? const SizedBox()
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child:
                                                                  ImageSlideshow(
                                                                children:
                                                                    assets,
                                                              ),
                                                            ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10.0,
                                                                right: 10),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                flex: 3,
                                                                child:
                                                                    AutoSizeText(
                                                                  articleProvider
                                                                      .filteredArticles[
                                                                          index]
                                                                      .title!,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(articleProvider
                                                                        .filteredArticles[
                                                                            index]
                                                                        .date!
                                                                        .toDate()
                                                                        .toString())),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10.0,
                                                                horizontal: 10),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            articleProvider
                                                                .filteredArticles[
                                                                    index]
                                                                .body!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              fontSize: 15.sm,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors.grey
                                                                  .shade500,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Provider.of<UserProvider>(context,
                                                          listen: false)
                                                      .isAdmin
                                                  ? Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            Widget
                                                                cancelButton =
                                                                TextButton(
                                                              child: const Text(
                                                                  "إلغاء"),
                                                              onPressed: () {
                                                                pop();
                                                              },
                                                            );
                                                            Widget
                                                                continueButton =
                                                                TextButton(
                                                              child: const Text(
                                                                  "تأكيد الحذف"),
                                                              onPressed: () {
                                                                pop();
                                                                articleProvider.deleteArticle(
                                                                    articleProvider
                                                                            .filteredArticles[index]
                                                                            .id ??
                                                                        "");
                                                              },
                                                            );

                                                            showDialog(
                                                                context: navigationKey
                                                                    .currentState!
                                                                    .context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            'تأكيد الحذف',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                          ),
                                                                          content:
                                                                              const Text(
                                                                            'هل انت متأكد من حذف المقالة ؟',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                          ),
                                                                          actions: [
                                                                            cancelButton,
                                                                            continueButton,
                                                                          ],
                                                                          actionsAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                        ));
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .delete_forever,
                                                            color: Colors.red,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount:
                                        articleProvider.filteredArticles.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 5.h,
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text('لا يوجد نتائج'),
                                  ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
