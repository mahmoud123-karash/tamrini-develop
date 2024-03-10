import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/features/profile/presentation/manager/location_cubit/location_states.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(InitialLocationState());

  static LocationCubit get(context) => BlocProvider.of(context);

  void getLocationAddress() async {
    String address = CacheHelper.getData(key: 'address') ?? '';
    if (address == '') {
      emit(LocationChangedLoadingState());
      String message = await handleLocationPermission();
      if (message == "") {
        Position location = await Geolocator.getCurrentPosition();
        String address = await getAddress(
            location: GeoPoint(location.latitude, location.longitude));
        String uid = CacheHelper.getData(key: 'uid');

        await FirebaseFirestore.instance.collection('users').doc(uid).update(
          {
            "location": GeoPoint(location.latitude, location.longitude),
            "address": address,
          },
        );
        saveAddress(address);
        emit(LocationChangedSuccessState(address));
      } else {
        emit(LocationChangedErrorState(message));
      }
    }
  }
}
