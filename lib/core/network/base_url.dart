class BaseUrl {
    static const String baseURl = 'http://127.0.0.1:8000/api';


      static final String login = "$baseURl/login";
  static final String signUp = "$baseURl/auth/register";
  static final String logOut = "$baseURl/auth/logout";
  static final String verifyOtp = "$baseURl/auth/verify-otp";
  static final String verifyForgotPasswordOtp = "$baseURl/auth/forgot/verify";
  static final String resendOtp = "$baseURl/auth/resend-otp";
}