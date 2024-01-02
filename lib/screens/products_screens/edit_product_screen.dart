import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/product.dart';
import 'package:tamrini/provider/Upload_Image_provider.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/utils/cache_helper.dart';
import 'package:tamrini/utils/widgets/Upload%20Image.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class EditProductScreen extends StatefulWidget {
  final Data product;
  final Product category;
  const EditProductScreen(
      {Key? key, required this.product, required this.category})
      : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreebState();
}

class _EditProductScreebState extends State<EditProductScreen> {
  String? oldTitle;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isAvailable = true;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    allPhotos.clear();

    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    allPhotos.clear();
    titleController.text = widget.product.title!;
    descriptionController.text = widget.product.description!;
    priceController.text = widget.product.price.toString();
    oldTitle = widget.product.title;
    isAvailable = widget.product.available!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build EditProductScreen' + widget.category.id.toString());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: globalAppBar("تعديل المنتج"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
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
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'تعديل المنتج',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'اسم المنتج',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 50,
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'وصف المنتج',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'السعر',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'متوفر',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Checkbox(
                                value: isAvailable,
                                onChanged: (value) {
                                  setState(() {
                                    isAvailable = value!;
                                  });
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ImageUploads(
                        photoUrl: widget.product.assets != null
                            ? widget.product.assets!
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            showLoaderDialog(context);
                            var images = await Provider.of<UploadProvider>(
                                    context,
                                    listen: false)
                                .uploadFiles();

                            CacheHelper.init();

                            if (titleController.text.isEmpty ||
                                descriptionController.text.isEmpty ||
                                priceController.text.isEmpty) {
                              pop();

                              Fluttertoast.showToast(
                                  msg: 'من فضلك ادخل البيانات كاملة');
                            } else if (allPhotos.isEmpty) {
                              pop();

                              Fluttertoast.showToast(msg: 'يجب إضافة صورة');
                            } else {
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .editProduct(
                                title: titleController.text,
                                images: images.cast<String>(),
                                description: descriptionController.text,
                                category: widget.category,
                                price: int.parse(priceController.text),
                                isAvailable: isAvailable,
                                oldProduct: widget.product,
                              );

                              pop();
                            }
                          } on Exception catch (e) {
                            pop();
                            Fluttertoast.showToast(msg: "حدث خطأ");
                          }
                        },
                        child: const Text('حفظ'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
