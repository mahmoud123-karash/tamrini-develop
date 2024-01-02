import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/product.dart';
import 'package:tamrini/provider/Upload_Image_provider.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/utils/cache_helper.dart';
import 'package:tamrini/utils/widgets/Upload%20Image.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class AddProductScreen extends StatefulWidget {
  final Product category;
  const AddProductScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: globalAppBar("إضافة منتج"),
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
                        'اضافة منتج',
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
                      const ImageUploads(),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            showLoaderDialog(context);

                            CacheHelper.init();

                            if (titleController.text.isEmpty ||
                                descriptionController.text.isEmpty ||
                                priceController.text.isEmpty) {
                              pop();
                              Fluttertoast.showToast(
                                  msg: 'من فضلك أدخل جميع البيانات');
                            } else if (allPhotos.isEmpty) {
                              pop();

                              Fluttertoast.showToast(msg: 'من فضلك أصف صورة');
                            } else {
                              var images = await Provider.of<UploadProvider>(
                                      context,
                                      listen: false)
                                  .uploadFiles();

                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .addProduct(
                                title: titleController.text,
                                images: images.cast<String>() ?? [],
                                description: descriptionController.text,
                                category: widget.category,
                                price: int.parse(
                                  priceController.text,
                                ),
                                isAvailable: isAvailable,
                              );

                              pop();
                            }
                          } on Exception catch (e) {
                            pop();
                            Fluttertoast.showToast(msg: "حدث خطأ");
                          }
                        },
                        child: const Text('إضافة المنتج'),
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
