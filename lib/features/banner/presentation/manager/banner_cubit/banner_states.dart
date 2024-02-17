import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';

abstract class BannerStates {}

class InitialBannerState extends BannerStates {}

class LoadingGetBannersState extends BannerStates {}

class SucessGetBannersState extends BannerStates {
  final List<BannerModel> list;

  SucessGetBannersState(this.list);
}

class ErrorGetBannersState extends BannerStates {
  final String message;

  ErrorGetBannersState(this.message);
}
