class LoginRepository {
  LoginRepository._();
  static final LoginRepository _instance = LoginRepository._();
  static LoginRepository get instance => _instance;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
