import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';

class RemoveProductIconWidget extends StatelessWidget {
  const RemoveProductIconWidget({
    super.key,
    required this.model,
  });
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          showCloseIcon: true,
          titleTextStyle: TextStyles.style17.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          title: model.title,
          desc: S.of(context).remove_product_q,
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            StoreCubit.get(context).removeProduct(
              store: StoreCubit.get(context).getStore(uid).first,
              oldModel: model,
              context: context,
            );
          },
        ).show();
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
