class SettingRepository {
  SettingRepository._();
  static final SettingRepository _instance = SettingRepository._();
  static SettingRepository get instance => _instance;

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<bool> contactUs(
    String name,
    String email,
    String subject,
    String message,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<bool> deleteAccount(String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
