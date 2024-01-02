import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/trainee.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class AddTraineeDietScreen extends StatefulWidget {
  // final User user;
  const AddTraineeDietScreen({Key? key}) : super(key: key);

  @override
  State<AddTraineeDietScreen> createState() => _AddTraineeDietScreenState();
}

class _AddTraineeDietScreenState extends State<AddTraineeDietScreen> {
  final titleController = TextEditingController();
  final day1Controller = TextEditingController();
  final day2Controller = TextEditingController();
  final day3Controller = TextEditingController();
  final day4Controller = TextEditingController();
  final day5Controller = TextEditingController();
  final day6Controller = TextEditingController();
  final day7Controller = TextEditingController();
  final durationController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    day1Controller.dispose();
    day2Controller.dispose();
    day3Controller.dispose();
    day4Controller.dispose();
    day5Controller.dispose();
    day6Controller.dispose();
    day7Controller.dispose();
    durationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        appBar: globalAppBar("إضافة نظام غذائي لمتدرب"),
        body: Consumer<TraineeProvider>(builder: (context, _, child) {
          return Consumer<TraineeProvider>(builder: (context, _, child) {
            return Padding(
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: 'عنوان النظام',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: durationController,
                            decoration: const InputDecoration(
                              labelText: 'مدة النظام',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: day1Controller,
                            decoration: const InputDecoration(
                              labelText: 'يوم السبت',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: day2Controller,
                            decoration: const InputDecoration(
                              labelText: 'يوم الاحد',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: day3Controller,
                            decoration: const InputDecoration(
                              labelText: 'يوم الاثنين',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: day4Controller,
                            decoration: const InputDecoration(
                              labelText: 'يوم الثلاثاء',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: day5Controller,
                            decoration: const InputDecoration(
                              labelText: 'يوم الاربعاء',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: day6Controller,
                            decoration: const InputDecoration(
                              labelText: 'يوم الخميس',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: day7Controller,
                            decoration: const InputDecoration(
                              labelText: 'يوم الجمعة',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                if (titleController.text.isNotEmpty &&
                                        durationController.text.isNotEmpty
                                    // day1Controller.text.isNotEmpty &&
                                    // day2Controller.text.isNotEmpty &&
                                    // day3Controller.text.isNotEmpty &&
                                    // day4Controller.text.isNotEmpty &&
                                    // day5Controller.text.isNotEmpty &&
                                    // day6Controller.text.isNotEmpty &&
                                    // day7Controller.text.isNotEmpty
                                    ) {
                                  String body =
                                      "يوم السبت : ${day1Controller.text}  \n \nيوم الاحد : ${day2Controller.text}  \n \nيوم الاثنين : ${day3Controller.text}  \n \nيوم الثلاثاء : ${day4Controller.text}  \n \nيوم الاربعاء : ${day5Controller.text}  \n \nيوم الخميس : ${day6Controller.text}  \n \nيوم الجمعة : ${day7Controller.text}  \n \n";

                                  Food diet = Food(
                                    title: titleController.text,
                                    foodData: body,
                                    duration: durationController.text,
                                  );
                                  //

                                  //
                                  await Provider.of<TraineeProvider>(context,
                                          listen: false)
                                      .addFoodToTrainee(diet);

                                  await Provider.of<TraineeProvider>(context,
                                          listen: false)
                                      .saveChangedSelectedTraineeData();
                                } else {
                                  pop();

                                  Fluttertoast.showToast(
                                      msg: "الرجاء إدخال جميع البيانات",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } catch (e) {
                                pop();

                                Fluttertoast.showToast(
                                    msg: "حدث خطأ ما",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: const Text('إضافة',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}
