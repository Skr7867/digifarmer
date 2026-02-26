class ApiUrls {
  static String baseUrl = 'https://backend-apis-t1qb.onrender.com';

  static String userRegisterApi = '$baseUrl/api/v1/auth/send-otp';
  static String verifyOtpApi = '$baseUrl/api/v1/auth/verify-otp';
  static String chooseRoleApi = '$baseUrl/api/v1/auth/choose-role';
  static String personalInfoApi = '$baseUrl/api/v1/auth/personal-details';
  static String loginSendOtp = '$baseUrl/api/v1/auth/login/send-otp';
  static String loginVerifyOtp = '$baseUrl/api/v1/auth/login/verify-otp';
  static String allPlansApi = '$baseUrl/api/v1/admin/plans';
}
