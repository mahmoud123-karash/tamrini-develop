import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/new_store_screen.dart';
import 'package:tamrini/features/store/presentation/views/store_screen.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_name_num_widget.dart';

import '../store_owner_screen.dart';
import 'store_chat_icon_widget.dart';
import 'store_image_widget.dart';

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget({super.key, required this.model});
  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    String uid = CacheHelper.getData(key: 'uid');
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          if (uid == model.storeOwnerUid) {
            navigateTo(context, const StoreOwnerScreen());
          } else {
            navigateTo(context, StoreScreen(model: model));
          }
        },
        child: Stack(
          children: [
            StoreImageWidget(
              image: model.image,
              width: getWidht,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: getHeight * 0.18,
                constraints: const BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[500],
                  borderRadius: BorderRadius.circular(15),
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
                        name: model.name,
                        num: model.storeOwnerUid == uid
                            ? model.products!.length
                            : model.products!
                                .where((element) => element.available)
                                .length,
                      ),
                      const Spacer(),
                      if (uid != model.storeOwnerUid)
                        StoreChatIconWidget(
                          icon: Icons.chat,
                          onPressed: () {
                            Uri smsUri = Uri(
                              scheme: 'sms',
                              path: model.contact,
                            );
                            openUri(url: smsUri);
                          },
                          color: appColor,
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (uid != model.storeOwnerUid)
                        StoreChatIconWidget(
                          icon: Icons.phone,
                          onPressed: () {
                            Uri phoneUri = Uri(
                              scheme: 'tel',
                              path: model.contact,
                            );
                            openUri(url: phoneUri);
                          },
                          color: Colors.amber.withOpacity(0.5),
                        ),
                      if (uid == model.storeOwnerUid)
                        StoreChatIconWidget(
                          icon: Icons.edit,
                          onPressed: () {
                            navigateTo(context, NewStoreScreen(model: model));
                          },
                          color: appColor,
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
