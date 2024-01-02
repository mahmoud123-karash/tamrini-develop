import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/product.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/screens/products_screens/Add_product_screen.dart';
import 'package:tamrini/screens/products_screens/product_details_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class ProductsScreen extends StatefulWidget {
  final Product product;
  final bool isAll;
  const ProductsScreen({Key? key, required this.product, this.isAll = false})
      : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List sortBy = [
    'الأقل سعراً',
    'الأعلى سعراً',
  ];

  @override
  void dispose() {
    Provider.of<ProductProvider>(navigationKey.currentContext!, listen: false)
        .clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,###,000');
    log('build ProductsScreen' + widget.product.id.toString());

    return Scaffold(
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("المنتجات"),
      body: Consumer<ProductProvider>(builder: (context, _, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchBar(_.searchController, (value) {
                  widget.isAll ? _.searchAll() : _.search(widget.product);
                }),
                // SizedBox(
                //   height: 50.h,
                //   child: ListView.builder(
                //
                //       scrollDirection: Axis.horizontal,
                //       itemCount: _.products.length,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: InkWell(
                //             onTap: () {
                //               _.changeCatSelected(index);
                //             },
                //             child: Container(
                //               decoration: BoxDecoration(
                //                   color: _.catSelected == index
                //                       ? kSecondaryColor!
                //                       : Colors.white,
                //                   borderRadius: BorderRadius.circular(10)),
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Center(
                //                   child: Text(
                //                     _.products[index].title ?? '',
                //                     style: TextStyle(
                //                         color: _.catSelected == index
                //                             ? Colors.white
                //                             : Colors.black),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         );
                //       }),
                // ),

                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  hint: Text(
                    "ترتيب حسب",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  disabledHint: Text(
                    "ترتيب حسب",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge!.color),
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
                  items: sortBy.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      onTap: () {
                        _.changeSelectedSortBy(value);
                      },
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10.0),
                //     border: Border.all(color: Colors.grey),
                //   ),
                //   width: 50.w,
                //   child: GestureDetector(
                //     onTap: () {
                //       // To(const AddArticlesScreen());
                //
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.all(3),
                //       child: Row(
                //         children: const [
                //           Icon(Icons.filter_list_outlined,
                //               color: kPrimaryColor),
                //           Text("فلتر",
                //               style: TextStyle(color: kPrimaryColor)),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                _.userProvider.isAdmin && !widget.isAll
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              color: kSecondaryColor!,
                              onPressed: () {
                                To(AddProductScreen(
                                  category: widget.product,
                                ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "إضافة منتج",
                                    style: TextStyle(
                                        fontSize: 18.sp, color: Colors.white),
                                  ),
                                ],
                              )),
                        ],
                      )
                    : const SizedBox(),
                _.searchController.text.isNotEmpty &&
                        _.selectedProductCat.isEmpty
                    ? const Center(
                        child: Text("لا يوجد منتجات بهذا الإسم"),
                      )
                    : _.selectedProductCat.isEmpty
                        ? const Center(
                            child: Text("لا يوجد منتجات"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            dragStartBehavior: DragStartBehavior.start,
                            itemCount: _.selectedProductCat.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  To(ProductDetailsScreen(
                                      product: _.selectedProductCat[index],
                                      category: widget.product,
                                      isAll: widget.isAll));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    // width: 100.w,
                                    height: 140.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SizedBox(
                                              width: 150.w,
                                              height: 200.h,
                                              child: Image(
                                                image: FirebaseImageProvider(
                                                    FirebaseUrl(_
                                                                .selectedProductCat[
                                                                    index]
                                                                .assets ==
                                                            null
                                                        ? ""
                                                        : _
                                                            .selectedProductCat[
                                                                index]
                                                            .assets![0])),
                                                fit: BoxFit.fill,
                                                // width: 50.w,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: AutoSizeText(
                                                            _
                                                                .selectedProductCat[
                                                                    index]
                                                                .title!,
                                                            // softWrap: false,
                                                            maxLines: 2,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                // fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      _.userProvider.isAdmin &&
                                                              !widget.isAll
                                                          ? Expanded(
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
                                                                    child:
                                                                        const Text(
                                                                      "تأكيد الحذف",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      pop();

                                                                      _.deleteProduct(
                                                                        product: widget
                                                                            .product
                                                                            .data![index],
                                                                        category:
                                                                            widget.product,
                                                                      );
                                                                    },
                                                                  );

                                                                  showDialog(
                                                                      context: navigationKey
                                                                          .currentState!
                                                                          .context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                                title: const Text(
                                                                                  'تأكيد الحذف',
                                                                                  textAlign: TextAlign.right,
                                                                                ),
                                                                                content: Text(
                                                                                  'هل انت متأكد من حذف  ${_.selectedProductCat[index].title} ؟',
                                                                                  textAlign: TextAlign.right,
                                                                                ),
                                                                                actions: [
                                                                                  continueButton,
                                                                                  cancelButton,
                                                                                ],
                                                                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                                              ));
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .delete_forever,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                            )
                                                          : Expanded(
                                                              child:
                                                                  const SizedBox()),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    _.selectedProductCat[index]
                                                        .description!,
                                                    // softWrap: true,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: AutoSizeText(
                                                    " ${formatter.format(_.selectedProductCat[index].price)}د.ع",
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            //     maxCrossAxisExtent:
                            //         MediaQuery.of(context).size.width / 2,
                            //     mainAxisSpacing: 30,
                            //     crossAxisSpacing: 5),
                          ),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
