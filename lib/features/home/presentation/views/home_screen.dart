import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_exercise_widget_builder.dart';
import 'package:tamrini/features/home/presentation/views/widgets/title_and_more_button_row_widget.dart';
import 'package:tamrini/model/exercise.dart';
import 'package:tamrini/model/product.dart';
import 'package:tamrini/provider/home_provider.dart';
import 'package:tamrini/screens/Articles_screens/Article_details_screen.dart';
import 'package:tamrini/screens/Articles_screens/Articles_screen.dart';
import 'package:tamrini/screens/exercises_screens/exercise_Article_details_screen.dart';
import 'package:tamrini/screens/exercises_screens/exercises_home_screen.dart';
import 'package:tamrini/screens/gym_screens/gym_details_screen.dart';
import 'package:tamrini/screens/gym_screens/gyms_screen.dart';
import 'package:tamrini/screens/products_screens/product_details_screen.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import 'widgets/home_loading_widget.dart';

int bannerIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int articleIndex = 0;
  int exerciseIndex = 0;
  int gymIndex = 0;
  int productIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    return Consumer<HomeProvider>(builder: (context, _, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const HomeExerciseWidgetBuilder(),

            _.articles.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "آخر المقالات",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            To(const ArticlesScreen());
                          },
                          child: const Text(
                            "المزيد",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            _.articles.isEmpty
                ? Container()
                : const SizedBox(
                    height: 15.0,
                  ),
            _.articles.isEmpty
                ? Container()
                : SizedBox(
                    height: getHeight * 0.3,
                    // width: getWidht,
                    child: ScrollSnapList(
                      dynamicSizeEquation: (double distance) {
                        return 1 - min(distance.abs() / 500, 0.2);
                        // return 1 - (distance / 1000);
                      },

                      // listViewPadding:
                      //     const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: _.articles.length,
                      itemSize: getWidht * 0.7,
                      // reverse: true,
                      dynamicItemSize: false,
                      shrinkWrap: true,
                      updateOnScroll: true,
                      focusOnItemTap: true,
                      onItemFocus: (index) {
                        // articleIndex = index;
                        // setState(() {});
                        print("focused item $index");
                      },
                      itemBuilder: (__, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            To(ArticleDetailsScreen(
                              article: _.articles[index],
                              type: 'existing',
                              isAll: true,
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image(
                                    image: FirebaseImageProvider(FirebaseUrl(
                                        _.articles[index].image!.first)),
                                    fit: BoxFit.fill,
                                    width: getWidht * 0.7,
                                    height: getHeight * 0.3,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    // constraints: const BoxConstraints(
                                    //   maxWidth: double.infinity,
                                    //   maxHeight: double.infinity,
                                    //
                                    // ),
                                    height: getHeight * 0.18,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[500],
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.blueGrey[500]!
                                              .withOpacity(0.0),
                                          Colors.blueGrey[500]!
                                              .withOpacity(0.5),
                                          Colors.blueGrey[500]!
                                              .withOpacity(0.8),
                                          Colors.blueGrey[500]!
                                              .withOpacity(1.0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Text(
                                              _.articles[index].title ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            _.articles[index].body!,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(
              height: 20.0,
            ),

            _.articles.isEmpty
                ? Container()
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
            const SizedBox(
              height: 20.0,
            ),

            // //products

            _.products.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "منتجات متنوعة",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _.productProvider.chooseProductCat(
                                _.productProvider.allProducts, true);
                          },
                          child: const Text(
                            "المزيد",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            _.products.isEmpty
                ? Container()
                : const SizedBox(
                    height: 15.0,
                  ),
            _.products.isEmpty
                ? Container()
                : SizedBox(
                    height: getHeight * 0.3,
                    // width: getWidht,
                    child: ScrollSnapList(
                      itemCount: _.products.length,
                      itemSize: getWidht * 0.7,
                      // reverse: true,
                      dynamicItemSize: true,
                      shrinkWrap: true,
                      dynamicSizeEquation: (double distance) {
                        return 1 - min(distance.abs() / 500, 0.2);
                        // return 1 - (distance / 1000);
                      },
                      onItemFocus: (index) {
                        print("focused item $index");
                      },
                      itemBuilder: (__, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            To(ProductDetailsScreen(
                              product: _.products[index],
                              category: Product(
                                id: _.products[index].id!,
                              ),
                              isAll: true,
                            ));
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image(
                                  image: FirebaseImageProvider(FirebaseUrl(
                                      _.products[index].assets!.first)),
                                  fit: BoxFit.fill,
                                  width: getWidht * 0.7,
                                  height: getHeight * 0.3,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  // constraints: const BoxConstraints(
                                  //   maxWidth: double.infinity,
                                  //   maxHeight: double.infinity,
                                  //
                                  // ),
                                  height: getHeight * 0.18,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[500],
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.blueGrey[500]!.withOpacity(0.0),
                                        Colors.blueGrey[500]!.withOpacity(0.5),
                                        Colors.blueGrey[500]!.withOpacity(0.8),
                                        Colors.blueGrey[500]!.withOpacity(1.0),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          _.products[index].title ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              "${_.products[index].price}د.ع",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5.0,
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
                        );
                      },
                    ),
                  ),
            const SizedBox(
              height: 20.0,
            ),
            _.products.isEmpty
                ? Container()
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
            const SizedBox(
              height: 20.0,
            ),

            // //Gym

            _.gyms.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "أقرب جيم",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            To(const GymsScreen());
                          },
                          child: const Text(
                            "المزيد",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            _.gyms.isEmpty
                ? Container()
                : const SizedBox(
                    height: 15.0,
                  ),
            _.gyms.isEmpty
                ? Container()
                : SizedBox(
                    height: getHeight * 0.3,
                    // width: getWidht,
                    child: ScrollSnapList(
                      itemCount: _.gyms.length,
                      itemSize: getWidht * 0.7,
                      // reverse: true,
                      dynamicItemSize: true,
                      shrinkWrap: true,
                      dynamicSizeEquation: (double distance) {
                        return 1 - min(distance.abs() / 500, 0.2);
                        // return 1 - (distance / 1000);
                      },
                      onItemFocus: (index) {
                        print("focused item $index");
                      },
                      itemBuilder: (__, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            To(GymDetailsScreen(
                              gym: _.gyms[index],
                              isAll: true,
                            ));
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image(
                                  image: FirebaseImageProvider(
                                      FirebaseUrl(_.gyms[index].assets.first)),
                                  fit: BoxFit.fill,
                                  width: getWidht * 0.7,
                                  height: getHeight * 0.3,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  // constraints: const BoxConstraints(
                                  //   maxWidth: double.infinity,
                                  //   maxHeight: double.infinity,
                                  //
                                  // ),
                                  height: getHeight * 0.18,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[500],
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.blueGrey[500]!.withOpacity(0.0),
                                        Colors.blueGrey[500]!.withOpacity(0.5),
                                        Colors.blueGrey[500]!.withOpacity(0.8),
                                        Colors.blueGrey[500]!.withOpacity(1.0),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            _.gyms[index].name ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              _.gyms[index].distance
                                                      .toPrecision(3)
                                                      .toString() ??
                                                  '',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            const Text(
                                              "km",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              " ${_.gyms[index].price.toString()}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 1.0,
                                            ),
                                            const Text(
                                              "د.ع/شهر",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
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
                        );
                      },
                    ),
                  ),

            SizedBox(
              height: 80.0.h,
            ),
          ],
        ),
      );
    });
  }
}
