import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/views/product_details_screen.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_info_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/remove_product_icon_widget.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.model,
  });
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          ProductDetailsScreen(
            id: model.id,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 140.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 140.h,
                    width: 120.w,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: FirebaseImageProvider(
                            FirebaseUrl(model.image),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  ProductInfoWidget(model: model),
                ],
              ),
              if (model.ownerUid == uid)
                Positioned(
                  bottom: 0,
                  left: Intl.getCurrentLocale() == 'en' ? null : 0,
                  right: Intl.getCurrentLocale() == 'ar' ? null : 0,
                  child: RemoveProductIconWidget(
                    model: model,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
