import 'package:flutter/material.dart';
import 'package:notienziert/features/Home/homeScreen.dart';
import 'package:notienziert/features/Registrations/auth_provider.dart';
import 'package:notienziert/features/Registrations/createNewPasswordScreen.dart';
import 'package:notienziert/features/Registrations/forgetPasswordScreen.dart';
import 'package:notienziert/features/Registrations/loginScreen.dart';
import 'package:notienziert/features/Registrations/signUpScreen.dart';
import 'package:notienziert/features/Settings/contactUsScreen.dart';
import 'package:notienziert/features/Settings/settingScreen.dart';
import 'package:notienziert/features/Settings/typography.dart';
import 'package:notienziert/features/Settings/usersScreen.dart';
import 'package:notienziert/features/onBoardingScreen.dart';
import 'package:notienziert/features/splashScreen.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/routing/routes.dart';
import 'package:notienziert/utils/appConfig.dart';
import 'package:provider/provider.dart';

class RouterX {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ------------- Splash Screen ---------------

      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AppConfig>(),
            child: SplashScreen(),
          ),
        );

      // ------------- Introduction Screens ---------------
      case Routes.intro:
        return MaterialPageRoute(
          builder: (_) => const Introduction(),
        );

      // ------------- Users Screens ---------------

      case Routes.users:
        return MaterialPageRoute(
          builder: (_) => UsersScreen(),
        );

      // ------------- Login Screen ---------------
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: LoginScreen(),
          ),
        );

      // ------------- Forget Password Screen ---------------
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: ForgetPassword(),
          ),
        );

      // ------------- Create Password Screen ---------------
      case Routes.createNewPassword:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: CreateNewPassword(),
          ),
        );

      // ------------- Signup Screen ---------------
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: Signup(),
          ),
        );

      // ------------- Home Screen ---------------
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      // ------------- Settings Screen ---------------
      case Routes.setting:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );

      // ------------- Theme Screen ---------------
      case Routes.typographyScreen:
        return MaterialPageRoute(
          builder: (_) => TypographyScreen(),
        );

      // ------------- Contact Us Screen ---------------
      case Routes.contactus:
        return MaterialPageRoute(
          builder: (_) => ContactUsScreen(),
        );

      // ------------- Default Route ---------------
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
