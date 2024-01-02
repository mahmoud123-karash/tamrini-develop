import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/trainee.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/screens/trainer_screens/courses_home_screen.dart';
import 'package:tamrini/screens/trainer_screens/diet_home_screen.dart';
import 'package:tamrini/screens/trainer_screens/followUp_screen.dart';
import 'package:tamrini/screens/trainer_screens/supplements_home_screen.dart';
import 'package:tamrini/utils/widgets/button_widget.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class TraineeProfileScreen extends StatefulWidget {
  const TraineeProfileScreen({Key? key}) : super(key: key);

  @override
  State<TraineeProfileScreen> createState() => _TraineeProfileScreenState();
}

class _TraineeProfileScreenState extends State<TraineeProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        persistentFooterButtons: [adBanner()],
        appBar: globalAppBar("ملف المتدرب"),
        body: Consumer<TraineeProvider>(builder: (context, _, child) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 50),

              buildName(_.selectedTrainee!),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: buildUpgradeButton("البيانات و المتابعة", () {
                  setState(() {
                    To(const FollowUpScreen());
                  });
                }),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //TODO: add the buttons
                      children: [
                        buildUpgradeButton("الكورسات", () {
                          setState(() {
                            To(const CoursesHomeScreen());
                          });
                        }),
                        const SizedBox(width: 24),
                        buildUpgradeButton("النظام الغذائي", () {
                          setState(() {
                            To(const DietHomeScreen());
                          });
                        }),
                      ],
                    ),
                    const SizedBox(height: 24),
                    buildUpgradeButton("المكملات الغذائية", () {
                      setState(() {
                        To(const SupplementsHomeScreen());
                      });
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              // NumbersWidget(trainer: widget.trainee),
              // const SizedBox(height: 48),
              // buildAbout(_.selectedTrainee!),
              const SizedBox(height: 48),
            ],
          );
        }),
      ),
    );
  }

  Widget buildName(Trainee user) => Column(
        children: [
          Text(
            user.name!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),

          Text(
            user.gender!.toString(),
          ),
          const SizedBox(height: 4),

          Text(
            "${user.age!} سنة",
          ),
          const SizedBox(height: 4),
          Text(
            user.number!.toString(),
          ),
          const SizedBox(height: 4),
          // user.dateOfSubscription == null ? Container():
          // Text(
          //   DateFormat('yyyy-MM-dd').format(DateTime.parse(
          //       user.dateOfSubscription!.toDate().toString())),
          //
          // ),
        ],
      );

  Widget buildUpgradeButton(String title, Function() onClicked) => ButtonWidget(
        text: title,
        onClicked: onClicked,
      );

  // Widget buildAbout(Trainee user) {
  //   TextEditingController notesController = TextEditingController();
  //   notesController.text = user.notes??"" ;
  //
  //   return Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 48),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             'ملاحظات',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 16),
  //           TextFormField(
  //             minLines: 1,
  //             maxLines: 50,
  //             controller: notesController,
  //             autovalidateMode: AutovalidateMode.onUserInteraction,
  //             validator: (_) {
  //
  //               Trainee trainee = user..notes = _ ;
  //               Provider.of<TraineeProvider>(context, listen: false).updateTrainee(trainee);
  //             },
  //             decoration: const InputDecoration(
  //               // labelText: 'المقال',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //
  //         ],
  //       ),
  //     );}
}
