import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/gym_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/gym_screens/Add_gym_screen.dart';
import 'package:tamrini/screens/gym_screens/gym_details_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../../utils/distripute_assets.dart';

class GymsScreen extends StatefulWidget {
  const GymsScreen({Key? key}) : super(key: key);

  @override
  State<GymsScreen> createState() => _GymsScreenState();
}

class _GymsScreenState extends State<GymsScreen> {
  List sortBy = [
    'الأقل سعراً',
    'الأعلى سعراً',
    'الأقرب',
    'الأبعد',
  ];
  @override
  void dispose() {
    Provider.of<GymProvider>(navigationKey.currentContext!, listen: false)
        .clearSearch();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    return Scaffold(
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("صالات الجيم"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<GymProvider>(
          builder: (context, _, child) {
            return _.isLoading
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          searchBar(_.searchController, (p0) => _.searchGym()),
                          Provider.of<UserProvider>(context, listen: false)
                                  .isAdmin
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        color: kSecondaryColor!,
                                        onPressed: () {
                                          To(const AddGymScreen());
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Icon(Icons.add_circle,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "اضافة صالة جديدة",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),
                                  ],
                                )
                              : const SizedBox(),
                          DropdownButton<String>(
                            borderRadius: BorderRadius.circular(10),
                            hint: Text(
                              "ترتيب حسب",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color),
                            ),
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: kPrimaryColor,
                            value: _.selectedSortBy,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: kPrimaryColor),
                            underline: Container(
                              height: 2,
                              color: kPrimaryColor,
                            ),
                            onChanged: (String? newValue) {
                              _.changeSelectedSortBy(newValue);
                            },
                            items:
                                sortBy.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                onTap: () {
                                  _.changeSelectedSortBy(value);
                                },
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          _.searchController.text.isNotEmpty &&
                                  _.filteredGyms.isEmpty
                              ? const Center(
                                  child: Text("لا يوجد جيم بهذا الإسم"),
                                )
                              : _.filteredGyms.isNotEmpty
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        List<Widget> assets = [];
                                        assets = distributeAssets(
                                            _.filteredGyms[index].assets);

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: getHeight * 0.3,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              onTap: () {
                                                To(GymDetailsScreen(
                                                    gym: _.filteredGyms[index],
                                                    isAll: false));
                                              },
                                              child: Stack(
                                                children: [
                                                  _.filteredGyms[index].assets
                                                          .isEmpty
                                                      ? const SizedBox()
                                                      : SizedBox(
                                                          height:
                                                              getHeight * 0.3,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            child:
                                                                ImageSlideshow(
                                                              children: assets,
                                                            ),
                                                          ),
                                                        ),
                                                  Provider.of<UserProvider>(
                                                              context,
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
                                                                  onPressed:
                                                                      () {
                                                                    pop();
                                                                  },
                                                                );
                                                                Widget
                                                                    continueButton =
                                                                    TextButton(
                                                                  child: const Text(
                                                                      "تأكيد الحذف",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red)),
                                                                  onPressed:
                                                                      () {
                                                                    pop();
                                                                    _.deleteGym(_
                                                                        .filteredGyms[
                                                                            index]
                                                                        .id);
                                                                  },
                                                                );

                                                                showDialog(
                                                                    context:
                                                                        navigationKey
                                                                            .currentContext!,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                              title: const Text(
                                                                                'تأكيد الحذف',
                                                                                textAlign: TextAlign.right,
                                                                              ),
                                                                              content: Text(
                                                                                'هل انت متأكد من حذف صالة  ${_.filteredGyms[index].name} ؟',
                                                                                textAlign: TextAlign.right,
                                                                              ),
                                                                              actions: [
                                                                                cancelButton,
                                                                                continueButton,
                                                                              ],
                                                                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                                            ));
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .delete_forever,
                                                                color:
                                                                    Colors.red,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    left: 0,
                                                    child: Container(
                                                      // height: getHeight * 0.1,
                                                      // width: getWidht * 0.7,
                                                      constraints:
                                                          const BoxConstraints(
                                                        maxWidth:
                                                            double.infinity,
                                                        maxHeight:
                                                            double.infinity,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .blueGrey[500],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors
                                                                .blueGrey[900]!
                                                                .withOpacity(
                                                                    0.0),
                                                            Colors
                                                                .blueGrey[500]!
                                                                .withOpacity(
                                                                    0.5),
                                                            Colors
                                                                .blueGrey[500]!
                                                                .withOpacity(
                                                                    0.8),
                                                            Colors
                                                                .blueGrey[500]!
                                                                .withOpacity(
                                                                    1.0),
                                                          ],
                                                        ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            spreadRadius: 5,
                                                            blurRadius: 10,
                                                          ),
                                                        ],
                                                      ),
                                                      child: SafeArea(
                                                        minimum:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AutoSizeText(
                                                              _
                                                                  .filteredGyms[
                                                                      index]
                                                                  .name,
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 22,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          15.sp,
                                                                    ),
                                                                    Text(
                                                                      "${_.filteredGyms[index].distance.toPrecision(3)} كم",
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                // Spacer(),

                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      " ${_.filteredGyms[index].price} دينار عراقي ",
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: _.filteredGyms.length,
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
          },
        ),
      ),
    );
  }
}
