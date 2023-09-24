import 'package:flutter/material.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/models/loginModel.dart';
import 'package:notienziert/repository/user_repo/login_repo.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/routing/routes.dart';
import 'package:notienziert/utils/appConfig.dart';

class AuthProvider extends ChangeNotifier {
  // ------------------ Login - Forget - Signup  ------------------
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // ------------------  Signup  ------------------
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  // ------------------  Forms Key  ------------------
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool hasError = false;
  bool isObscure = true;
  bool rememberMe = true;

  //
  String? keyGender;
  Map<String, String>? selectedGender;

  //
  List<Map<String, String>> gender = [
    {"M": "Male"},
    {"F": "Female"}
  ];

  // ------------------ change Loader Auth ------------------

  changeLoaderAuth(value) {
    loading = value;
    notifyListeners();
  }

  // ------------------ Remember Me ------------------

  void remember(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  // ------------------ Password Visibility ------------------

  void visibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  // ------------------ Select Gender ------------------

  void selectGender(selected) {
    selectedGender = selected;
    selectedGender!.forEach((key, value) {
      keyGender = key;
      notifyListeners();
    });
  }

  // ------------------ Login ------------------

  Future<void> loginProvider() async {
    //try
    if (loginFormKey.currentState!.validate()) {
      LoginResponse res = await sl<LoginRepository>().userLogin(
          email: emailController.text, password: passwordController.text);
      sl<SharedLocal>().setUser(res.object!);
      sl<NavigationService>().navigateToAndRemove(Routes.home);
      AppConfig.showSnakBar("Logged", Success: true);
    }
    //catch
  }

  // ------------------ Sign Up Provider ------------------

  Future<void> SignupProvider() async {
    if (signUpFormKey.currentState!.validate()) {
      LoginResponse res = await sl<LoginRepository>().userSignup(
          name: fullname.text,
          email: emailController.text,
          password: passwordController.text,
          gender: keyGender!);
      AppConfig.showSnakBar(
          "${res.message ?? "Account was created Successfully!!"}",
          Success: true);
      sl<NavigationService>().navigateToAndRemove(Routes.login);
    }
  }

  // ------------------ Forget Provider ------------------

  Future<void> forgetProvider() async {
    if (forgetFormKey.currentState!.validate()) {
      LoginResponse res = await sl<LoginRepository>()
          .userForgetPassword(email: emailController.text);

      sl<SharedLocal>().setSignUpTempo("${emailController.text}");
      sl<SharedLocal>().setCode = res.code!;
      AppConfig.showSnakBar("${res.message}", Success: true);
      sl<NavigationService>().navigateToAndRemove(Routes.createNewPassword);
    }
  }

  // ------------------ Change Password Provider ------------------

  void changePasswordProvider() async {
    if (formKey2.currentState!.validate()) {
      LoginResponse response = await sl<LoginRepository>().changePassword(
          currentPassword: currentPass.text, newPassword: newPass.text);
      AppConfig.showSnakBar("${response.message}", Success: true);
      sl<NavigationService>().navigateToAndRemove(Routes.login);
    }
  }
}
