import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/chat/presentation/views/chat_screen.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/store_chat_icon_widget.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/store_name_num_widget.dart';

class StoreCoverImageWidget extends StatelessWidget {
  const StoreCoverImageWidget({
    super.key,
    required this.name,
    required this.contact,
    required this.uid,
    required this.image,
    required this.num,
  });
  final String name, contact, uid, image;
  final int num;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Stack(
        children: [
          Image(
            image: FirebaseImageProvider(
              FirebaseUrl(image),
              options: const CacheOptions(
                checkForMetadataChange: false,
              ),
            ),
            fit: BoxFit.cover,
            height: getHeight / 3.8,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: getHeight * 0.20,
              constraints: const BoxConstraints(
                maxWidth: double.infinity,
                maxHeight: double.infinity,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey[500],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueGrey[900]!.withOpacity(0.0),
                    Colors.blueGrey[500]!.withOpacity(0.5),
                    Colors.blueGrey[500]!.withOpacity(0.8),
                    Colors.blueGrey[500]!.withOpacity(1.0),
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StoreNameNumWidget(
                      name: name,
                      num: num,
                    ),
                    const Spacer(),
                    StoreChatIconWidget(
                      icon: Icons.chat,
                      onPressed: () {
                        navigateTo(
                          context,
                          ChatScreen(
                            name: name,
                            recieverUid: uid,
                            uid: CacheHelper.getData(key: 'uid'),
                          ),
                        );
                      },
                      color: appColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StoreChatIconWidget(
                      icon: Icons.phone,
                      onPressed: () {
                        Uri phoneUri = Uri(
                          scheme: 'tel',
                          path: contact,
                        );
                        openUri(url: phoneUri);
                      },
                      color: Colors.amber.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
