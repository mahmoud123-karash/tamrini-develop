import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/navigation_route.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

// GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
// GlobalKey<NavigatorState> get navigationKey => _navigationKey;

void navigateTo(context, route) => Navigator.push(
      context,
      createRoute(route),
    );

void navigateToAndReplace(context, route) => Navigator.pushReplacement(
      context,
      createRoute(route),
    );

void navigateToAndFinish(context, route) => Navigator.pushAndRemoveUntil(
      context,
      createRoute(route),
      (route) => false,
    );

void showToast(
  String message, {
  ToastGravity? gravity = ToastGravity.BOTTOM,
}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: appColor,
    gravity: gravity,
    textColor: whiteColor,
    toastLength: Toast.LENGTH_SHORT,
  );
}

void showSnackBar(context, message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );

AppBar myAppBar(
  title, {
  List<Widget>? actions,
}) =>
    AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
      ),
      actions: actions,
    );

Widget searchField({
  required TextEditingController controller,
  required Function(String) onChanged,
}) =>
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Ionicons.search_outline,
          ),
          hintText: S.of(navigationKey.currentContext!).search,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );

Widget loadingWidget() => Center(
      child: SizedBox(
        height: 80.h,
        child: Center(
          child: Image.asset(
            Assets.imagesLoading,
          ),
        ),
      ),
    );

AwesomeDialog logOutDialog(context) => AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.bottomSlide,
      title: S.of(context).log_out,
      titleTextStyle: const TextStyle(),
      desc: S.of(context).log_out_question,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        logOut(context);
      },
    );

Widget addCustomButton({
  required VoidCallback onPressed,
  required String lable,
  IconData icon = Icons.add_circle,
  double fontSize = 20,
}) =>
    MaterialButton(
      color: appColor,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: whiteColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              lable,
              style: TextStyles.style20.copyWith(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );

Widget customButton({
  required VoidCallback onPressed,
  required String lable,
  Color? color,
}) =>
    Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        minWidth: double.infinity,
        height: 40,
        color: color ?? appColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        onPressed: onPressed,
        child: Text(
          lable,
          style: TextStyles.style16Bold.copyWith(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget addTextField({
  required String lable,
  required TextEditingController controller,
  required BuildContext context,
  TextInputType? keyboardType,
  required AutovalidateMode autovalidateMode,
}) =>
    TextFormField(
      maxLines: null,
      autovalidateMode: autovalidateMode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).validate;
        }
        return null;
      },
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: lable,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
    );

Widget addFromGalleryItems({
  required String title,
  required IconData icon,
  required VoidCallback function,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 43.h,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      IconButton(
        onPressed: function,
        icon: Icon(
          icon,
          color: const Color(0xFF7A90B7),
          size: 40,
        ),
      )
    ],
  );
}

Widget imageProviderWidget({
  required double height,
  required double width,
  required ImageProvider<Object> imageProvider,
}) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image(
        height: height,
        width: width,
        image: imageProvider,
        fit: BoxFit.cover,
        loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return SizedBox(
              height: height,
              width: width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );

Widget messageBuilder({
  required String message,
}) =>
    Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Text(
          message,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

Widget banWidget({
  required String lable,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.red,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                lable,
                style: TextStyles.style14.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
