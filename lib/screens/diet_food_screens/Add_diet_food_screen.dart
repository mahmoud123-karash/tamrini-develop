import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/diet_food.dart';
import 'package:tamrini/provider/Upload_Image_provider.dart';
import 'package:tamrini/provider/diet_food_provider.dart';
import 'package:tamrini/utils/cache_helper.dart';
import 'package:tamrini/utils/widgets/Upload%20Image.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class AddDietFoodScreen extends StatefulWidget {
  const AddDietFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddDietFoodScreen> createState() => _AddDietFoodScreebState();
}

class _AddDietFoodScreebState extends State<AddDietFoodScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    allPhotos.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: globalAppBar("إضافة"),
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
                        'اضافة أكلة دايت',
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
                          labelText: 'اسم الأكلة',
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
                          labelText: 'تفاصيل الأكلة',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ImageUploads(),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            if (titleController.text.isNotEmpty &&
                                descriptionController.text.isNotEmpty) {
                              showLoaderDialog(context);
                              var images = await Provider.of<UploadProvider>(
                                      context,
                                      listen: false)
                                  .uploadFiles();

                              CacheHelper.init();

                              DietFood dietFood = DietFood(
                                title: titleController.text,
                                description: descriptionController.text,
                                assets: images,
                                date: Timestamp.fromDate(DateTime.now()),
                                writer: CacheHelper.getString(key: "username"),
                                id: '',
                              );

                              Provider.of<DietFoodProvider>(context,
                                      listen: false)
                                  .addMeal(dietFood);

                              pop();
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'من فضلك ادخل البيانات كاملة');
                            }
                          } on Exception catch (e) {
                            pop();
                            Fluttertoast.showToast(msg: "حدث خطأ");
                          }
                        },
                        child: const Text('إضافة أكلة الدايت'),
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
