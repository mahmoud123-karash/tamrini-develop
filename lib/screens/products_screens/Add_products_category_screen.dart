import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/Upload_Image_provider.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/utils/widgets/Upload%20Image.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class AddProductCategoryScreen extends StatefulWidget {
  const AddProductCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddProductCategoryScreen> createState() =>
      _AddProductCategoryScreenState();
}

class _AddProductCategoryScreenState extends State<AddProductCategoryScreen> {
  TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: globalAppBar("إضافة قسم منتجات"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: MediaQuery.of(context).size.height- 500,
            width: double.infinity,
            // width: double.infinity,
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
              onWillPop: () async {
                allPhotos.clear();

                return true;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'إضافة قسم جديد',
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
                        labelText: 'اسم القسم',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ImageUploads(
                      isOneImage: true,
                      isVideo: false,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          showLoaderDialog(context);
                          var images = await Provider.of<UploadProvider>(
                                  context,
                                  listen: false)
                              .uploadFiles();
                          log('images: $images');
                          log('title: ${titleController.text}');

                          if (titleController.text.isNotEmpty) {
                            if (images.isEmpty) {
                              Fluttertoast.showToast(msg: 'من فضلك ادخل صورة');
                              pop();
                              return;
                            }
                            log('images: $images');
                            log('title: ${titleController.text}');

                            Provider.of<ProductProvider>(context, listen: false)
                                .addCategory(
                              title: titleController.text,
                              image: images[0],
                            );

                            // pop();
                            pop();
                          } else {
                            pop();

                            Fluttertoast.showToast(
                                msg: 'من فضلك ادخل البيانات كاملة');
                          }
                        } on Exception catch (e) {
                          pop();
                          Fluttertoast.showToast(msg: "حدث خطأ");
                        }
                      },
                      child: const Text('إضافة القسم'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
