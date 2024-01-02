import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/trainer.dart';
import 'package:tamrini/provider/trainer_provider.dart';
import 'package:tamrini/screens/trainer_screens/add_gallery_item_screen.dart';

import '../../utils/constants.dart';
import '../../utils/distripute_assets.dart';
import '../../utils/widgets/global Widgets.dart';

class GalleryScreen extends StatelessWidget {
  final Trainer? trainer;
  const GalleryScreen({this.trainer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: globalAppBar('معرض الأعمال'),
        body: Consumer<TrainerProvider>(
          builder: (context, _, child) {
            Trainer? currentTrainer;
            if (_.trainers.isNotEmpty) {
              currentTrainer = trainer ?? _.trainers
                  .firstWhere((trainer) => trainer.uid == _.user!.user.uid);
            }
            print('current trainer: ${currentTrainer?.name}');
            return _.isLoading
                ? Center(
                    child: Image.asset('assets/images/loading.gif',
                        height: 100.h, width: 100.w),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        if(_.user!.isCaptain)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              color: kSecondaryColor!,
                              onPressed: () {
                                To(AddGalleryItemScreen(
                                  trainer: currentTrainer!,
                                ));
                                // show modal or screen to add work
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.add_circle,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "اضافة عمل",
                                    style: TextStyle(
                                        fontSize: 18.sp, color: Colors.white),
                                  ),
                                ],
                              )),
                        ),
                        // const Spacer(),
                        if (currentTrainer?.gallery == null ||
                            currentTrainer?.gallery?.isEmpty == true)
                          const Center(child: Text('لا توجد أعمال حاليا')),
                        if (currentTrainer?.gallery != null &&
                            currentTrainer?.gallery?.isNotEmpty == true) ...[
                          const SizedBox(height: 24),
                          ListView.separated(
                            reverse: true,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 15.h,
                              );
                            },
                            itemBuilder: (context, index) {
                              print(
                                  'gallery length: ${currentTrainer!.gallery}');
                              var images = distributeAssets([
                                currentTrainer!.gallery![index]['before'],
                                currentTrainer.gallery![index]['after']
                              ]);
                              return Card(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: ImageSlideshow(
                                    children: [
                                      for (var i = 0; i < images.length; i++)
                                        InkWell(
                                          onTap: () {
                                            showDialog<dynamic>(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return OrientationBuilder(
                                                    builder:
                                                        (context, orientation) {
                                                      return StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return Scaffold(
                                                          appBar: AppBar(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFEFF2F7),
                                                            elevation: 0,
                                                            iconTheme:
                                                                const IconThemeData(
                                                                    color: Color(
                                                                        0xFF003E4F)),
                                                            centerTitle: false,
                                                            title: Text(
                                                              'المعرض',
                                                              style: TextStyle(
                                                                fontSize: 20.sp,
                                                                color: const Color(
                                                                    0xff007c9d),
                                                              ),
                                                            ),
                                                          ),
                                                          body: Container(
                                                            // height: 1.sh,
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                ImageSlideshow(
                                                              height: 1.sh,
                                                              children: images,
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                  );
                                                });
                                          },
                                          child: Stack(
                                            children: [
                                              images[i],
                                              Positioned(
                                                top: -2,
                                                right: 16,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.only(
                                                        bottomRight: Radius.circular(8),
                                                        bottomLeft: Radius.circular(8)),
                                                    ),
                                                  child:  Text(
                                                    i == 0 ? 'قبل' : 'بعد',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: currentTrainer!.gallery!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ]
                      ],
                    ),
                  );
          },
        ));
  }
}
