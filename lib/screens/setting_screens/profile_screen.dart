import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/user.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/setting_screens/edit_profile_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/button_widget.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../trainer_screens/gallery_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("الملف الشخصي"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),

              // Center(
              //   child: ProfileWidget(
              //     isUser: true,
              //     //TODO: change image
              //     // imagePath:""widget.user.image!,
              //     imagePath: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
              //     onClicked: () {
              //         Provider.of<TrainerProvider>(context, listen: false).user;
              //             CacheHelper.getString(key: 'id') ==  widget.user.uid ?
              //        To(EditProfileScreen(user: widget.user)): null;
              //     },
              //   ),
              // ),

              const SizedBox(height: 24),
              buildName(widget.user),
              const SizedBox(height: 24),

              // Center(child: buildUpgradeButton()),
              // const SizedBox(height: 24),
              // NumbersWidget(trainer: widget.user),
              if(widget.user.role == 'captain')
                InkWell(
                onTap: () => To(const GalleryScreen()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      "معرض الأعمال",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 10,),
                    const Icon(
                      Ionicons.arrow_back_circle_outline,
                      color: Colors.blue,
                      size: 25,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),
              InkWell(
                  onTap: () {
                    To(EditProfileScreen(user: widget.user));
                  },
                  child: Text(
                    "تعديل البيانات",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 48),
              InkWell(
                  onTap: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .deleteAccount();
                  },
                  child: Text(
                    "حذف حسابي وبياناتي",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    textAlign: TextAlign.center,
                  )),
              // buildAbout(widget.user),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
          ),
          const SizedBox(height: 4),
          Text(
            user.username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
          ),
          const SizedBox(height: 4),
          Text(
            user.gender,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              user.isVerifiedEmail
                  ? const Icon(
                      Icons.verified,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.error_outline_outlined,
                      color: Colors.red,
                    ),
              Text(
                user.email,
              ),
              !user.isVerifiedEmail
                  ? MaterialButton(
                      onPressed: () {
                        Provider.of<UserProvider>(context, listen: false)
                            .verifyEmail();
                      },
                      child: Text("تفعيل"),
                      color: kSecondaryColor,
                      textColor: Colors.white,
                      minWidth: 10,
                      height: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            user.phone,
          ),
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'تغيير كلمة المرور',
        onClicked: () {
          ;
        },
      );

  // Widget buildAbout(Trainer user) => Container(
  //   padding: const EdgeInsets.symmetric(horizontal: 48),
  //   child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'الانجازات',
  //         style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 16),
  //       Text(
  //         user.description!,
  //         style: TextStyle(fontSize: 16.sp, height: 1.4),
  //       ),
  //     ],
  //   ),
  // );
}
