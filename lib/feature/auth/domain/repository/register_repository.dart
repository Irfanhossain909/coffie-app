class RegisterRepository {
  RegisterRepository._();
  static final RegisterRepository _instance = RegisterRepository._();
  static RegisterRepository get instance => _instance;

  Future<bool> register(String name, String email, String password, String confirmPassword) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}