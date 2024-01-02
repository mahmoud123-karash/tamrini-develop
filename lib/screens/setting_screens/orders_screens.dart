import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class OrdersScreens extends StatefulWidget {
  const OrdersScreens({Key? key}) : super(key: key);

  @override
  State<OrdersScreens> createState() => _OrdersScreensState();
}

class _OrdersScreensState extends State<OrdersScreens> {
  var formatter = NumberFormat('###,###,000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
        'Orders',
      ),
      body: Consumer<ProductProvider>(
        builder: (context, _, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _.isLoading
                ? Center(
                    child: Image.asset('assets/images/loading.gif',
                        height: 100.h, width: 100.w),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        if (_.orders.isEmpty)
                          const Center(
                            child: Text('لا يوجد طلبات'),
                          )
                        else
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0, 1))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            // fit: FlexFit.loose,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _.orders[index].product!
                                                      .title!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'العنوان : ${_.orders[index].address}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 10,
                                                ),
                                                Text(
                                                    'ملاحظات : ${_.orders[index].notes}',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    )),
                                                const Divider(
                                                  color: Colors.grey,
                                                  endIndent: 50,
                                                ),
                                                Text(
                                                    "الإسم :  ${_.orders[index].user!}",
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    )),
                                                Text(
                                                    _.orders[index]
                                                        .phoneNumber!,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    )),
                                                Text(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.parse(_
                                                          .orders[index]
                                                          .createdAt!
                                                          .toDate()
                                                          .toString())),
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${formatter.format(_.orders[index].product!.price!)}  د.ع",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  '${_.orders[index].product!.quantity}  قطعة',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  "${formatter.format(_.orders[index].product!.price! * _.orders[index].product!.quantity!)}د.ع ",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'الحالة : ${_.orders[index].status}',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                _.orders[index].image != null &&
                                                        _.orders[index].image !=
                                                            ""
                                                    ? InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Dialog(
                                                                child: SizedBox(
                                                                  height: 500.h,
                                                                  width: 500.w,
                                                                  child:
                                                                      PhotoView(
                                                                    imageProvider:
                                                                        FirebaseImageProvider(
                                                                      FirebaseUrl(
                                                                        _.orders[index]
                                                                            .image!,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: const Text(
                                                            "صورة الدفع",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.blue,
                                                            )),
                                                      )
                                                    : const SizedBox(),
                                                Text(
                                                    _.orders[index]
                                                        .paymentMethod!,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.green,
                                              onPressed: () {
                                                _.updateOrderStatus(
                                                    id: _.orders[index].id ??
                                                        "",
                                                    status: "مقبوله");
                                              },
                                              child: Text(
                                                'قبول',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white,
                                                ),
                                              )),
                                          MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.red,
                                              onPressed: () {
                                                _.updateOrderStatus(
                                                    id: _.orders[index].id ??
                                                        "",
                                                    status: "مرفوضه");
                                              },
                                              child: Text(
                                                'رفض',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white,
                                                ),
                                              )),
                                          MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.red,
                                              onPressed: () {
                                                Widget cancelButton =
                                                    TextButton(
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
                                                    _.deleteOrder(
                                                        id: _.orders[index]
                                                                .id ??
                                                            "");
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
                                                            'هل انت متأكد من حذف الطلب ؟',
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                          actions: [
                                                            cancelButton,
                                                            continueButton,
                                                          ],
                                                          actionsAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                        ));
                                              },
                                              child: Text(
                                                'حذف',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                            itemCount: _.orders.length,
                          ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
