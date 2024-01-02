import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/provider/trainer_provider.dart';
import 'package:tamrini/screens/trainer_screens/pending_trainees_screen.dart';
import 'package:tamrini/screens/trainer_screens/pending_trainers_screen.dart';

import '../provider/user_provider.dart';
import '../utils/widgets/global Widgets.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: globalAppBar('الإشعارات', isLeading: false),
        body: Consumer<UserProvider>(
          builder: (context, myType, child) {
            var myL = myType.user.notifications.reversed.toList();
            return myType.user.notifications == null ||
                    myType.user.notifications.isEmpty
                ? const Center(
                    child: Text('لا يوجد إشعارات'),
                  )
                : ListView.builder(
                    itemCount: myType.user.notifications.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            switch (myL[index]['title']) {
                              case 'طلب تدريب جديد':
                                Provider.of<TraineeProvider>(context,
                                        listen: false)
                                    .fetchAndSetPendingTrainees();
                                To(const PendingTraineesScreen());
                                break;

                              case ' طلب انضمام مدرب جديد':
                                print('object');
                                Provider.of<TrainerProvider>(context,
                                        listen: false)
                                    .fetchAndSetPendingTrainers();
                                To(const PendingTrainersScreen());

                                break;
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(myL[index]['title']),
                              subtitle: Text(myL[index]['body']),
                              trailing: Text(
                                DateFormat('hh:mm  yyyy-MM-dd').format(
                                    DateTime.parse(myL[index]['createsAt']
                                        .toDate()
                                        .toString())),
                                style: TextStyle(fontSize: 12),
                              ),

                              // trailing: InkWell(
                              //     onTap: () {
                              //       myType.deleteNotification(
                              //           myType.user.notifications[index]['id']);
                              //     },
                              //     child: const Icon(Icons.delete)),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
