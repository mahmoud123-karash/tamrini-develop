abstract class RegisterRepo {
  Future<String> signUp({
    required String email,
    required String password,
  });
  void createUser({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String uid,
  });
}
