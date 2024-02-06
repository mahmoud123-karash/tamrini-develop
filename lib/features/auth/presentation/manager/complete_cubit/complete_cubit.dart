import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamrini/features/auth/domain/repo/register_repo.dart';
import 'package:tamrini/features/auth/presentation/manager/complete_cubit/complete_states.dart';

class CompleteCubit extends Cubit<CompleteStates> {
  CompleteCubit(this.registerRepo) : super(InitialCompleteState());
  static CompleteCubit get(context) => BlocProvider.of(context);

  final RegisterRepo registerRepo;

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String uid,
  }) async {
    emit(LoadingCompleteState());
    try {
      registerRepo.createUser(
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        uid: uid,
      );
      emit(SuccessCompleteState(uid));
    } catch (e) {
      emit(ErrorCompleteState(e.toString()));
    }
  }

  void signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    emit(SignOutState());
  }
}
