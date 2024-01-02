import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/trainer_provider.dart';
import 'package:tamrini/screens/trainer_screens/trainer_profile_screen.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class PendingTrainersScreen extends StatelessWidget {
  const PendingTrainersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("الاشتراكات المعلقة"),
      body: Consumer<TrainerProvider>(builder: (context, _, child) {
        return _.isLoading
            ? Center(
                child: Image.asset('assets/images/loading.gif',
                    height: 100.h, width: 100.w),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: _.pendingTrainers.isEmpty
                    ? [
                        const Spacer(),
                        const Center(child: Text("لا يوجد اشتراكات معلقة")),
                        const Spacer(),
                      ]
                    : [
                        const SizedBox(height: 10),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                onTap: () {
                                  To(TrainerProfileScreen(
                                      trainer: _.pendingTrainers[index]));
                                },
                                title: Text(_.pendingTrainers[index].name!),
                                subtitle: Text(
                                  _.pendingTrainers[index].description ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: CircleAvatar(
                                  radius: 30.sp,
                                  backgroundImage: NetworkImage(
                                      _.pendingTrainers[index].image!),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _.acceptTrainer(
                                            _.pendingTrainers[index]);
                                      },
                                      icon: const Icon(Icons.check,
                                          color: Colors.green),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _.rejectTrainer(
                                            _.pendingTrainers[index]);
                                      },
                                      icon: const Icon(Icons.close,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: _.pendingTrainers.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        const SizedBox(height: 10),
                      ],
              );
      }),
    );
  }
}
