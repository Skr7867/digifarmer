class ApiUrls {
  // static String baseUrl = 'https://backend-apis-t1qb.onrender.com';
  static String baseUrl = 'https://api.digifarmer.in';

  static String userRegisterApi = '$baseUrl/api/v1/auth/send-otp';
  static String verifyOtpApi = '$baseUrl/api/v1/auth/verify-otp';
  static String chooseRoleApi = '$baseUrl/api/v1/auth/choose-role';
  static String personalInfoApi = '$baseUrl/api/v1/auth/personal-details';
  static String loginSendOtp = '$baseUrl/api/v1/auth/login/send-otp';
  static String loginVerifyOtp = '$baseUrl/api/v1/auth/login/verify-otp';
  static String allPlansApi = '$baseUrl/api/v1/admin/plans/active';
  static String userProfileApi = '$baseUrl/api/v1/auth/me';
  static String activeInvestmentApi = '$baseUrl/api/v1/investor/investments';
  static String createPayment(String planId) =>
      '$baseUrl/api/v1/investor/payments/create-order/$planId';
  static String updateProfileApi = '$baseUrl/api/v1/auth/profile';
  static String verifyPayment = '$baseUrl/api/v1/investor/payments/verify';
  static String investmentDetailsApi(String planId) =>
      '$baseUrl/api/v1/investor/investments/$planId';
  static String kycStatusApi = '$baseUrl/api/v1/kyc/status';
  static String submitBankDetailsApi = '$baseUrl/api/v1/kyc/bank-details';
  static String withdrawalAmountApi  = "$baseUrl/api/v1/wallet/withdraw";
  static String uploadPanUrl = '$baseUrl/api/v1/kyc/upload/pan';
  static String uploadAadhaarUrl = '$baseUrl/api/v1/kyc/upload/aadhaar';
  static String uploadSelfieUrl = '$baseUrl/api/v1/kyc/upload/selfie';
  static String submitKycDocumentsApi = '$baseUrl/api/v1/kyc/submit';
  static String resendOtp = '$baseUrl/api/v1/auth/login/resend-otp';
  static String walletApi = '$baseUrl/api/v1/wallet/details';

  //*********************************Land owner panel api */
  static String landOwnerSaveBasicInfoApi =
      '$baseUrl/api/v1/land-owner/lands/step1/basic-info';
  static String landLocationApi =
      '$baseUrl/api/v1/land-owner/lands/step2/location';
  static String presignedUrlsApi =
      '$baseUrl/api/v1/land-owner/lands/step3/presigned-urls';
  static String confirmUploadApi =
      '$baseUrl/api/v1/land-owner/lands/step3/confirm';
  static String landStatusApi = '$baseUrl/api/v1/timeline/lands/timeline/all';
  static String planPurchasedApi = '$baseUrl/api/v1/investor/investments/apply';

  // ***************************workerApi from here ************************

  static String workerDashBoardDataApi = '$baseUrl/api/v1/worker/dashboard';

  static String workerAllTaskApi = '$baseUrl/api/v1/worker/tasks';
  static String taskDetailsApi(String taskId) =>
      '$baseUrl/api/v1/worker/tasks/$taskId/dashboard';
  static String startTaskApi(String taskId) =>
      '$baseUrl/api/v1/worker/tasks/$taskId/start';
  static String taskUpdateApi(String taskId) =>
      '$baseUrl/api/v1/worker/tasks/$taskId/progress';
  static String taskCompleteApi(String taskId) =>
      '$baseUrl/api/v1/worker/tasks/$taskId/complete';
  static String workerCheckInApi = '$baseUrl/api/v1/worker/attendance/checkin';
  static String workerCheckOutApi =
      '$baseUrl/api/v1/worker/attendance/checkout';
  static String workerAttendanceHistoryApi =
      '$baseUrl/api/v1/worker/attendance';
  static String landDetailsApi(String taskId) =>
      '$baseUrl/api/v1/worker/tasks/land/$taskId';
}
