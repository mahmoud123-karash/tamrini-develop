import 'dart:developer';
import 'widgets/curved_nav_bar_widget.dart';
import 'drawer_widget.dart';
import 'package:tamrini/core/utils/improts.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  void didChangeDependencies() {
    String userType = CacheHelper.getData(key: 'usertype') ?? "";
    String uid = CacheHelper.getData(key: 'uid') ?? "";
    String trainerId = CacheHelper.getData(key: 'trainerId') ?? "";

    if (uid != '') {
      if (userType == UserType.trainer) {
        TraineeCubit.get(context).getData(trainerId: uid);
      }
      if (userType == UserType.admin || userType == UserType.user) {
        PromotionCubit.get(context).getData();
      }
      Timer.periodic(
        const Duration(minutes: 5),
        (timer) {
          if (userType != UserType.admin && userType != UserType.trainer) {
            if (mounted) {
              AdMobCubit.get(context).createInterstitialAd();
            }
          }
        },
      );
      if (userType == UserType.admin) {
        ProfitsCubit.get(context).getData();
      }
      ProfitsCubit.get(context).pList.clear();
      FavoriteCubit.get(context).getData();
      OrderCubit.get(context).getData();
      UserOrderCubit.get(context).getData();
      UpdateCubit.get(context).update();
      LocationCubit.get(context).getLocationAddress();
      NotificationCubit.get(context).getData();
      DayCubit.get(context).getData();
      OrderCubit.get(context).getData();
      log(CacheHelper.getData(key: 'deviceToken') ?? '');
      initiGetprofile(context);
      getintil(context);
      onMessageOpenedApp(context: context);
      onMessage(context: context);
      listenNotification();
      if (trainerId != '') {
        UserCourseCubit.get(context).getCourse();
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? "";
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarStates>(
        builder: (context, state) {
          NavBarCubit cubit = NavBarCubit.get(context);
          return PopScope(
            canPop: cubit.currentIndex == 2 ? true : false,
            onPopInvoked: (didPop) {
              if (cubit.currentIndex != 2) {
                cubit.changeIndex(2);
              }
            },
            child: Scaffold(
              drawer: const MyDrawer(),
              appBar: myAppBar(
                cubit.titles(context)[cubit.currentIndex],
                actions: [
                  if (uid != '') const BadgeNotificationIconWidget(),
                ],
              ),
              bottomNavigationBar: CurvedNavBarWidget(cubit: cubit),
              body: cubit.screens[cubit.currentIndex],
            ),
          );
        },
      ),
    );
  }
}
