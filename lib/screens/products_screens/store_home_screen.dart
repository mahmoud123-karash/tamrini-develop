import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/products_screens/Add_products_category_screen.dart';
import 'package:tamrini/screens/products_screens/edit_category_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class ProductsHomeScreen extends StatefulWidget {
  const ProductsHomeScreen({super.key});

  @override
  State<ProductsHomeScreen> createState() => _ProductsHomeScreenState();
}

class _ProductsHomeScreenState extends State<ProductsHomeScreen> {
  // @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ProductProvider>(builder: (context, _, child) {
        return _.isLoading
            ? Center(
                child: Image.asset('assets/images/loading.gif',
                    height: 100.h, width: 100.w),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _.userProvider.isAdmin
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 20),
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                color: kSecondaryColor!,
                                onPressed: () {
                                  To(const AddProductCategoryScreen());
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
                                      "إضافة قسم جديد",
                                      style: TextStyle(
                                          fontSize: 18.sp, color: Colors.white),
                                    ),
                                  ],
                                )),
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _.chooseProductCat(_.allProducts, true);
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        constraints: BoxConstraints(
                          minHeight: 100.spMax,
                          minWidth: 100,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/allProduct.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "جميع المنتجات",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        controller: ScrollController(),
                        // dragStartBehavior: DragStartBehavior.start,
                        itemCount: _.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _.chooseProductCat(_.products[index], false);
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              constraints: const BoxConstraints(
                                minHeight: 100,
                                minWidth: 100,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  colorFilter: const ColorFilter.mode(
                                      Colors.black45, BlendMode.darken),
                                  image: ((_.products[index].image) != null &&
                                          _.products[index].image!.isNotEmpty)
                                      ? FirebaseImageProvider(
                                          FirebaseUrl(_.products[index].image!),
                                        )
                                      : const AssetImage(
                                              "assets/images/allProduct.jpg")
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Provider.of<UserProvider>(context,
                                                listen: false)
                                            .isAdmin
                                        ? IconButton(
                                            onPressed: () {
                                              Widget cancelButton = TextButton(
                                                child: const Text("إلغاء"),
                                                onPressed: () {
                                                  pop();
                                                },
                                              );
                                              Widget continueButton =
                                                  TextButton(
                                                child: const Text(
                                                  "تأكيد الحذف",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  pop();

                                                  _.deleteCategory(
                                                      id: _
                                                          .products[index].id!);
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
                                                        content: Text(
                                                          'هل انت متأكد من حذف قسم ${_.products[index].title} ؟',
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
                                              Icons.delete_forever,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          )
                                        : const SizedBox(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: AutoSizeText(
                                            _.products[index].title!,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .isAdmin
                                            ? IconButton(
                                                onPressed: () {
                                                  To(EditPROCategoryScreen(
                                                    category: _.products[index],
                                                  ));
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.yellow,
                                                  size: 30,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width / 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
