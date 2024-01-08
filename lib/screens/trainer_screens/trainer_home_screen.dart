import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/provider/trainer_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/trainer_screens/trainer_profile_screen.dart';
import 'package:tamrini/screens/trainer_screens/trainer_req_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../setting_screens/settings_screen.dart';

class TrainerHomeScreen extends StatefulWidget {
  const TrainerHomeScreen({Key? key}) : super(key: key);

  @override
  State<TrainerHomeScreen> createState() => _TrainerHomeScreenState();
}

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  @override
  void dispose() {
    Provider.of<TrainerProvider>(navigationKey.currentContext!, listen: false)
        .clearSearch();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    Provider.of<TraineeProvider>(context, listen: false)
        .fetchAndSetPendingTrainees();

    Provider.of<TrainerProvider>(context, listen: false)
        .fetchAndSetPendingTrainers();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    return Scaffold(
        persistentFooterButtons: [adBanner()],
        appBar: globalAppBar("صفحة المدربين"),
        body: Consumer<TrainerProvider>(builder: (context, _, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                searchBar(_.searchController, (p0) => _.searchTrainer()),
                const SizedBox(height: 20),
                !_.user!.isCaptain && !_.user!.isAdmin
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: kSecondaryColor!,
                            onPressed: () {
                              !Provider.of<UserProvider>(context, listen: false)
                                          .user
                                          .isVerifiedPhoneNumber &&
                                      !Provider.of<UserProvider>(context,
                                              listen: false)
                                          .user
                                          .isVerifiedEmail
                                  ? AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'خطأ',
                                      desc:
                                          'يجب تأكيد البريد الالكتروني أو رقم الهاتف أولا من الإعدادات',
                                      btnOkOnPress: () {
                                        To(SettingsScreen());
                                      },
                                    ).show()
                                  : To(
                                      TrainerRequestScreen(user: _.user!.user));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.stars_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "الترقية الى حساب مدرب",
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.white),
                                ),
                              ],
                            )))
                    : const SizedBox(),
                _.isLoading
                    ? Center(
                        child: Image.asset('assets/images/loading.gif',
                            height: 100.h, width: 100.w),
                      )
                    : _.searchController.text.isNotEmpty && _.trainers.isEmpty
                        ? Center(
                            child: Text(
                              "لا يوجد نتائج",
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                          )
                        : _.trainers.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      height: getHeight * 0.3,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          To(TrainerProfileScreen(
                                            trainer: _.trainers[index],
                                          ));
                                        },
                                        child: Stack(
                                          children: [
                                            _.trainers[index].image!.isEmpty
                                                ? const SizedBox()
                                                : SizedBox(
                                                    width: getWidht,
                                                    height: getHeight * 0.3,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Image(
                                                        image:
                                                            FirebaseImageProvider(
                                                                FirebaseUrl(_
                                                                    .trainers[
                                                                        index]
                                                                    .image!)),
                                                        fit: BoxFit.cover,
                                                        width:
                                                            getWidht * 0.7 - 20,
                                                        height: getHeight * 0.3,
                                                      ),
                                                    ),
                                                  ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              child: Container(
                                                // height: getHeight * 0.1,
                                                // width: getWidht * 0.7,
                                                constraints:
                                                    const BoxConstraints(
                                                  maxWidth: double.infinity,
                                                  maxHeight: double.infinity,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey[500],
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.blueGrey[900]!
                                                          .withOpacity(0.0),
                                                      Colors.blueGrey[500]!
                                                          .withOpacity(0.5),
                                                      Colors.blueGrey[500]!
                                                          .withOpacity(0.8),
                                                      Colors.blueGrey[500]!
                                                          .withOpacity(1.0),
                                                    ],
                                                  ),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 5,
                                                      blurRadius: 10,
                                                    ),
                                                  ],
                                                ),
                                                child: SafeArea(
                                                  minimum: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _.trainers[index].name!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.sp,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Text(
                                                        _.trainers[index]
                                                                .description ??
                                                            "",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .white,
                                                                size: 15.sp,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "${_.trainers[index].traineesCount ?? "0"} متدرب ",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // Spacer(),

                                                          Row(
                                                            children: [
                                                              Text(
                                                                " ${_.trainers[index].price} د.ع/شهر ",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Provider.of<UserProvider>(context,
                                                        listen: false)
                                                    .isAdmin
                                                ? Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Widget cancelButton =
                                                              TextButton(
                                                            child: const Text(
                                                                "إلغاء"),
                                                            onPressed: () {
                                                              pop();
                                                            },
                                                          );
                                                          Widget
                                                              continueButton =
                                                              TextButton(
                                                            child: const Text(
                                                                "تأكيد الحذف",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red)),
                                                            onPressed: () {
                                                              pop();
                                                              _.deleteTrainer(
                                                                  _.trainers[
                                                                      index]);
                                                            },
                                                          );

                                                          showDialog(
                                                              context: navigationKey
                                                                  .currentContext!,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title:
                                                                            const Text(
                                                                          'تأكيد الحذف',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                        ),
                                                                        content:
                                                                            Text(
                                                                          'هل انت متأكد من حذف المدرب  ${_.trainers[index].name} ؟',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                        ),
                                                                        actions: [
                                                                          cancelButton,
                                                                          continueButton,
                                                                        ],
                                                                        actionsAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                      ));
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete_forever,
                                                          color: Colors.red,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: _.trainers.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 5.h,
                                  );
                                },
                              )
                            : const Center(
                                child: Text('لا يوجد نتائج'),
                              ),
              ],
            ),
          );
        }));
  }
}
