import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/improts.dart';

void openUri({required Uri url}) async {
  await launchUrl(url).then((value) {
    if (kDebugMode) {
      print(value);
    }
  });
}

Future<void> share({
  required String title,
  required String text,
}) async {
  await FlutterShare.share(
    title: title,
    text: text,
    linkUrl: appLink,
  );
}

double calculateAverageRating(List<Rating> ratings) {
  if (ratings.isEmpty) {
    return 0.0;
  }
  double sum = 0.0;
  for (Rating rating in ratings) {
    sum += rating.rating;
  }
  double average = sum / ratings.length;
  return average;
}

Future showAppBottomSheet(
  context,
  widget, {
  bool isDismissible = true,
}) {
  return showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 0.9,
    context: context,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    useRootNavigator: isDismissible,
    constraints: const BoxConstraints(),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (context) => widget,
  );
}

String formatTimeDifference(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks week${weeks > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  }
}

String formatTimeDifferenceInArabic(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'الآن';
  } else if (difference.inMinutes < 60) {
    return 'منذ ${difference.inMinutes} دقائق';
  } else if (difference.inHours < 24) {
    return 'منذ ${difference.inHours} ساعات';
  } else if (difference.inDays < 7) {
    return 'منذ ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return 'منذ $weeks ${weeks == 1 ? 'أسبوع' : 'أسابيع'}';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return 'منذ $months ${months > 1 ? 'أ' : ''}شهر';
  } else {
    final years = (difference.inDays / 365).floor();
    return 'منذ $years ${years == 1 ? 'ًسنة' : 'سنوات'}';
  }
}

void initiGetprofile(context) {
  var box = Hive.box<ProfileModel>(profileBox);
  if (box.values.isEmpty) {
    ProfileCubit.get(context).getProfile();
  }
}

void logOut(context) async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  if (await googleSignIn.isSignedIn()) {
    googleSignIn.disconnect();
  }
  await FirebaseAuth.instance.signOut();
  navigateToAndFinish(context, const LoginScreen());
  String uid = CacheHelper.getData(key: 'uid') ?? '';
  if (uid != '') {
    await FirebaseFirestore.instance.collection('users').doc(uid).update(
      {
        'token': "",
      },
    );
  }
  var box = Hive.box<ProfileModel>(profileBox);
  await box.clear();
  var box1 = Hive.box<DayModel>(dayBox);
  await box1.clear();
  var box2 = Hive.box<MealModel>(favoriteBox);
  await box2.clear();
  clearSubBox();
  CacheHelper.removeData(key: 'deviceToken');
  CacheHelper.removeData(key: 'trainerId');
  CacheHelper.removeData(key: 'address');
  CacheHelper.removeData(key: 'uid');
}

void showReminderBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      borderSide: BorderSide.none,
    ),
    builder: (context) => widget,
  );
}

bool isTimeAfter(DateTime givenTime) {
  final currentDateTime = DateTime.now();
  return givenTime.isAfter(currentDateTime);
}

DateTime nextScheduledDate(hour, minute) {
  final DateTime now = DateTime.now();
  DateTime scheduledDate = DateTime(
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

String formatNumber(int number) {
  final formatter = NumberFormat.compact(
    locale: Intl.getCurrentLocale(),
  );
  return formatter.format(number);
}

void clearSubBox() async {
  var box = Hive.box<SubscriptionModel>(subBox);
  await box.clear();
}

Future<UserModel> getUser(String uid) async {
  var result =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  GeoPoint defultLocation = const GeoPoint(33.312805, 44.361488);
  GeoPoint location = result.data() == null
      ? defultLocation
      : result.data()!['location'] ?? defultLocation;
  String address = await getAddress(location: location);
  UserModel user = UserModel.fromMap(result.data()!, result.id, address);

  return user;
}

UserModel getUserFromProfile() {
  var box = Hive.box<ProfileModel>(profileBox);
  ProfileModel model = box.values.toList().first;
  String type = CacheHelper.getData(key: 'usertype') ?? '';
  String token = CacheHelper.getData(key: 'deviceToken') ?? '';
  String uid = CacheHelper.getData(key: 'uid') ?? '';
  UserModel user = UserModel(
    email: model.email,
    role: type,
    gender: model.gender,
    whatsApp: model.whatsApp ?? '',
    name: model.name,
    image: model.image,
    token: token,
    facebookUri: model.facebookUri,
    uid: uid,
    instgramUri: model.instgramUri,
    isBanned: model.isBanned,
    address: model.address,
    twiterUri: model.twiterUri,
    phone: model.phone,
  );
  return user;
}

void showWaringLoginDialog(context) {
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
    dialogType: DialogType.info,
    animType: AnimType.bottomSlide,
    desc: S.of(context).login_first_please,
    btnOkOnPress: () {},
  ).show();
}
