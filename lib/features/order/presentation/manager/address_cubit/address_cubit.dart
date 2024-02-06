import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/order/presentation/manager/address_cubit/address_states.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit() : super(InitialAddressState());
  static AddressCubit get(context) => BlocProvider.of(context);

  int amount = 1;
  void addAmout() async {
    amount++;
    emit(AmountAddState());
  }

  void removeAmout() async {
    if (amount == 1) {
      return;
    } else {
      amount--;
      emit(AmountRemoveState());
    }
  }
}
