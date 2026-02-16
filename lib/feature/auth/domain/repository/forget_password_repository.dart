class ForgetPasswordRepository {
  ForgetPasswordRepository._();
  static final ForgetPasswordRepository _instance =
      ForgetPasswordRepository._();

  static ForgetPasswordRepository get instance => _instance;

  Future<bool> forgetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<bool> newPassword(String password, String confirmPassword) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
