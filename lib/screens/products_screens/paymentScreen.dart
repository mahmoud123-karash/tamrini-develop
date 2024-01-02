import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/product.dart';
import 'package:tamrini/provider/Upload_Image_provider.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/Upload%20Image.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class PaymentScreen extends StatefulWidget {
  final Data product;
  const PaymentScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedItem = 1;
  int _selectedItem2 = 1;
  int _selectedItem3 = 1;
  PaymentMethod _paymentMethod = PaymentMethod.cashOnDelivery;

  var formatter = NumberFormat('###,###,000');

  String? address;

  String notes = "";
  @override
  void initState() {
    allPhotos = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar("الشراء"),
      body: Consumer<ProductProvider>(builder: (context, _, child) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.product.assets != null ||
                              widget.product.assets!.isNotEmpty
                          ? Image(
                              image: FirebaseImageProvider(
                                  FirebaseUrl(widget.product.assets![0])),
                              height: 50,
                              width: 50,
                            )
                          : const Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(widget.product.title ?? ''),
                            Text(
                              " ${formatter.format(widget.product.price)}د.ع",
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(children: [
                        const Text("الكمية"),
                        const SizedBox(width: 10),
                        DropdownButton(
                          value: _selectedItem,
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text("1"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("2"),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text("3"),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text("4"),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text("5"),
                            ),
                          ],
                          onChanged: (int? value) {
                            setState(() {
                              _selectedItem = value!;
                            });
                          },
                        ),
                      ]),
                    ]),
                const SizedBox(height: 24),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Text(
                  'المجموع : ${formatter.format(widget.product.price! * _selectedItem)}د.ع',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // const Text("العنوان"),
                Column(
                  children: [
                    TextFormField(
                      maxLines: 3,
                      minLines: 1,
                      decoration: const InputDecoration(
                        hintText: "العنوان",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "ملاحظات",
                      ),
                      onChanged: (value) {
                        setState(() {
                          notes = value;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                const Text("طريقة الدفع"),
                Column(
                  children: [
                    RadioListTile<PaymentMethod>(
                      value: PaymentMethod.cashOnDelivery,
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                        });
                      },
                      title: const Text("الدفع عند الاستلام"),
                    ),
                    RadioListTile<PaymentMethod>(
                      value: PaymentMethod.moneyTransfer,
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                        });
                      },
                      title: const Text("الدفع عن طريق المحفظة الالكترونية"),
                    ),
                    _paymentMethod != PaymentMethod.moneyTransfer
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 40),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _.digitalPaymentMethods.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (_.digitalPaymentMethods[index]
                                            .isActive ==
                                        false) {
                                      return const SizedBox.shrink();
                                    }
                                    return RadioListTile(
                                      value: index,
                                      groupValue: _selectedItem3,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedItem3 = value!;
                                        });
                                      },
                                      title: Text(_.digitalPaymentMethods[index]
                                              .title ??
                                          ''),
                                      subtitle: Text(_
                                              .digitalPaymentMethods[index]
                                              .phoneNumber ??
                                          ''),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text("يجب رفع ايصال الدفع قبل الطلب"),
                              const ImageUploads(
                                isOneImage: true,
                                isVideo: false,
                              ),
                            ],
                          ),
                  ],
                ),

                const SizedBox(height: 24),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: kSecondaryColor,
                    onPressed: () async {
                      if (_paymentMethod == PaymentMethod.moneyTransfer &&
                          _selectedItem3 == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("يجب اختيار طريقة الدفع")));
                        return;
                      }
                      if (address == null || address!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("يجب ادخال العنوان")));
                        return;
                      }
                      if (_paymentMethod == PaymentMethod.cashOnDelivery) {
                        _.buyProduct(
                          product: widget.product,
                          quantity: _selectedItem,
                          address: address ?? "",
                          notes: notes,
                          paymentMethod: _paymentMethod,
                          // digitalPaymentMethod: _.digitalPaymentMethods[_selectedItem3!]
                        );
                        return;
                      } else {
                        var images = await Provider.of<UploadProvider>(context,
                                listen: false)
                            .uploadFiles();
                        if (images.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("يجب رفع صورة")));
                          return;
                        }
                        _.buyProduct(
                          product: widget.product,
                          quantity: _selectedItem,
                          address: address ?? "",
                          notes: notes,
                          paymentMethod: _paymentMethod,
                          image: images[0],
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.add_circle, color: Colors.white),
                          ),
                          Text(
                            "اتمام الشراء",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
