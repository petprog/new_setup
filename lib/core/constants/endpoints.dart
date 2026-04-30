class AppEndpoints {
  AppEndpoints._();
  static const baseUrl = String.fromEnvironment('BASE_URL');
  static const webAppUrl = String.fromEnvironment('WEB_APP_URL');

  static const register = "/auth/register";
  static const login = "/auth/login";
  static const user = "/auth/user";
  static const loginGoogle = "/auth/login/google";
  static const deleteProfile = "/auth/profile";
  static const loginApple = "/auth/login/apple";
  static const refreshToken = "/auth/refresh-token";
  static const resetPassword = "/auth/forgot-password";
  static const fogotPassword = "/auth/password/forgot";
  static const changePassword = "/auth/change-password";
  static const sendEmailOtp = "/auth/send-email-otp";
  static const sendSmsOtp = "/auth/send-sms-otp";
  static const validateEmailOtp = "/auth/validate-otp";
  static const validateSmsOtp = "/auth/validate-otp";
  static const verifyBusinessInitiate = "/auth/identity-verification/initiate";
  static const getIdVerificationStatus = "/auth/identity-verification/status";
}
