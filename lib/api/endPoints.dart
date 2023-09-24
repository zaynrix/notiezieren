class Endpoints {
  Endpoints._();

  // base url
  static String baseUrl = "http://demo-api.mr-dev.tech/api";
  static String auth = "/students/auth";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String login = '/login';
  static const String signUp = '/register';
  static const String forgetPassword = '/forget-password';
  static const String tasks = '/tasks';
  static const String userImages = '/student/images';
  static const String resetPassword = '/reset-password';

}