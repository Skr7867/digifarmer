class ApiUrls {
  static String baseUrl = 'https://backend-apis-t1qb.onrender.com';

  static String userRegisterApi = '$baseUrl/api/v1/auth/send-otp';
  static String verifyOtpApi = '$baseUrl/api/v1/auth/verify-otp';
  static String chooseRoleApi = '$baseUrl/api/v1/auth/choose-role';
}
