import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/trainer.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/trainer_screens/add_followUp_screen.dart';
import 'package:tamrini/utils/cache_helper.dart';
import 'package:tamrini/utils/widgets/button_widget.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';
import 'package:tamrini/utils/widgets/numbers_widget.dart';
import 'package:tamrini/utils/widgets/profile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../setting_screens/settings_screen.dart';
import 'gallery_screen.dart';

class TrainerProfileScreen extends StatefulWidget {
  final Trainer trainer;

  const TrainerProfileScreen({Key? key, required this.trainer})
      : super(key: key);

  @override
  State<TrainerProfileScreen> createState() => _TrainerProfileScreenState();
}

class _TrainerProfileScreenState extends State<TrainerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("ملف المدرب الشخصي"),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: widget.trainer.image!,
            onClicked: () {
              // Provider.of<TrainerProvider>(context, listen: false).user;
              // CacheHelper.getString(key: 'id') == widget.trainer.uid
              //     ? To(EditTrainerProfileScreen(user: widget.trainer))
              //     : null;
            },
          ),
          const SizedBox(height: 24),
          buildName(widget.trainer),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
          NumbersWidget(trainer: widget.trainer),
          const SizedBox(height: 48),
          buildAbout(widget.trainer),
          const SizedBox(height: 48),
          buildTrainerGallery(widget.trainer),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget buildName(Trainer user) => Column(
        children: [
          Text(
            user.name!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),

          Row(
            mainAxisAlignment:
                CacheHelper.getString(key: 'id') != widget.trainer.uid &&
                        !Provider.of<UserProvider>(context, listen: false)
                            .user
                            .isSubscribedToTrainer
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
            children: [
              CacheHelper.getString(key: 'id') != widget.trainer.uid &&
                      !Provider.of<UserProvider>(context, listen: false)
                          .user
                          .isSubscribedToTrainer
                  ? Center(child: buildUpgradeButton(widget.trainer))
                  : Container(),
              ButtonWidget(
                text: 'تواصل معي',
                onClicked: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('تواصل معي'),
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (user.contacts![0].contains("+")) {
                                      launchUrl(Uri.parse(
                                          "tel:${user.contacts![0]}"));
                                    }
                                    launchUrl(Uri.parse(user.contacts![0]));
                                  },
                                  child: const Icon(
                                    Ionicons.call,
                                    color: Colors.blue,
                                    size: 34,
                                  ),
                                ),
                                user.contacts![1].isEmpty
                                    ? const SizedBox()
                                    : const SizedBox(width: 16),
                                user.contacts![1].isEmpty
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse(user.contacts![1]));
                                        },
                                        child: const Icon(
                                          Ionicons.logo_facebook,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                user.contacts![2].isEmpty
                                    ? const SizedBox()
                                    : const SizedBox(width: 16),
                                user.contacts![2].isEmpty
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse(user.contacts![2]));
                                        },
                                        child: const Icon(
                                          Ionicons.logo_twitter,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                user.contacts![3].isEmpty
                                    ? const SizedBox()
                                    : const SizedBox(width: 16),
                                user.contacts![3].isEmpty
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse(user.contacts![3]));
                                        },
                                        child: const Icon(
                                          Ionicons.logo_instagram,
                                          color: Colors.pink,
                                          size: 40,
                                        ),
                                      ),
                              ],
                            ),
                          ));
                },
              )
            ],
          ),
          // for (var i = 0; i < user.contacts!.length; i++)
          //   InkWell(
          //     onTap: () {
          //       launchUrl(Uri.parse(user.contacts![i]));
          //     },
          //     child: Text(
          //       user.contacts![i],
          //       style: const TextStyle(color: Colors.blue),
          //     ),
          //   ),
        ],
      );

  Widget buildUpgradeButton(
    Trainer trainer,
  ) =>
      ButtonWidget(
        text: 'اشتراك',
        onClicked: () {
          print('clicked');
          if (!Provider.of<UserProvider>(context, listen: false)
                  .user
                  .isVerifiedPhoneNumber &&
              !Provider.of<UserProvider>(context, listen: false)
                  .user
                  .isVerifiedEmail) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: 'خطأ',
              desc:
                  'يجب تأكيد البريد الالكتروني أو رقم الهاتف أولا من الإعدادات',
              btnOkOnPress: () {
                To(SettingsScreen());
              },
            ).show();
            return;
          }
          To(AddFollowUpScreen(isNewSub: true, trainer: trainer));
          // Provider.of<TrainerProvider>(context, listen: false)
          //     .subscribeToTrainer(widget.trainer);
        },
      );

  Widget buildAbout(Trainer trainer) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الانجازات',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              trainer.description ?? '',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildTrainerGallery(Trainer trainer) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => To(GalleryScreen(
                trainer: trainer,
              )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'معرض الأعمال',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Ionicons.arrow_back_circle_outline,
                    color: Colors.blue,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
