import '../../features/home/data/models/gym_model/gym_model.dart';

List<GymModel> sortByPrice(bool isAscending, List<GymModel> list) {
  if (isAscending) {
    list.sort((a, b) {
      return a.price.compareTo(b.price);
    });
  } else {
    list.sort((a, b) {
      return b.price.compareTo(a.price);
    });
  }

  return list;
}

List<GymModel> sortByDistance(bool isAscending, List<GymModel> list) {
  if (isAscending) {
    list.sort((a, b) {
      return a.distance.compareTo(b.distance);
    });
  } else {
    list.sort((a, b) {
      return b.distance.compareTo(a.distance);
    });
  }
  return list;
}
