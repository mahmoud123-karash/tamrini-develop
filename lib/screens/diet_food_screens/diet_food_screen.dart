import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tamrini/provider/diet_food_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/diet_food_screens/Add_diet_food_screen.dart';
import 'package:tamrini/screens/diet_food_screens/diet_food_details_screen.dart';
import 'package:tamrini/screens/diet_food_screens/pending_diet_food_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/distripute_assets.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class DietFoodScreen extends StatefulWidget {
  const DietFoodScreen({Key? key}) : super(key: key);

  @override
  State<DietFoodScreen> createState() => _DietFoodScreenState();
}

class _DietFoodScreenState extends State<DietFoodScreen> {
  @override
  void dispose() {
    Provider.of<DietFoodProvider>(navigationKey.currentContext!, listen: false)
        .clearSearch();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("أكلات دايــت"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<DietFoodProvider>(builder: (context, _, child) {
          return _.isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Image.asset('assets/images/loading.gif',
                        height: 100.h, width: 100.w),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    _.fetchAndSetMeals();
                    _.fetchAndSetPendingMeal();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        searchBar(_.searchController, (p0) => _.search()),
                        user.isAdmin || user.isCaptain
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: user.isCaptain
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
                                              To(const AddDietFoodScreen());
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Icon(Icons.add_circle,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "اضافة أكلة دايت",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    user.isCaptain
                                        ? const SizedBox()
                                        : Padding(
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
                                                    _.fetchAndSetPendingMeal();
                                                    To(const PendingDietFoodScreen());
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
                                                        "الأكلات المعلقة : ${_.pendingFood.length}",
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
                              )
                            : const SizedBox(),
                        _.searchController.text.isNotEmpty &&
                                _.filteredFoodList.isEmpty
                            ? const Center(
                                child: Text("لا يوجد اكلات دايت بهذا الإسم"),
                              )
                            : _.filteredFoodList.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      List<Widget> assets = [];
                                      if (_.filteredFoodList[index].assets !=
                                          null) {
                                        assets = distributeAssets(
                                            _.filteredFoodList[index].assets);
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            To(DietFoodDetailsScreen(
                                              dietfood:
                                                  _.filteredFoodList[index],
                                              type: 'existing',
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
                                                      _.filteredFoodList[index]
                                                                      .assets ==
                                                                  null ||
                                                              _
                                                                  .filteredFoodList[
                                                                      index]
                                                                  .assets!
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
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 3,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    _.filteredFoodList[index]
                                                                            .title ??
                                                                        '',
                                                                    maxLines: 2,
                                                                    // presetFontSizes: [25.sp, 20.sp, 14.sp],
                                                                    // maxLines: 4,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              _.filteredFoodList[index]
                                                                          .date !=
                                                                      null
                                                                  ? Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(_
                                                                              .filteredFoodList[index]
                                                                              .date!
                                                                              .toDate()
                                                                              .toString())),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(),
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
                                                            _
                                                                .filteredFoodList[
                                                                    index]
                                                                .description!,
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
                                              _.isAdmin
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
                                                                _.deleteMeal(_
                                                                        .filteredFoodList[
                                                                            index]
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
                                                                            'هل انت متأكد من حذف أكلة الدايت ؟',
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
                                    itemCount: _.filteredFoodList.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 5.h,
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0),
                                      child: Text('لا يوجد نتائج'),
                                    ),
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
