import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Home/homePro.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/routing/routes.dart';

import '../interceptors/dio_exception.dart';

class AppConfig extends ChangeNotifier {
  var shared = sl<SharedLocal>();

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    if (shared.firstIntro == true) {
      if (shared.getUser().token == null) {
        sl<NavigationService>().navigateToAndRemove(Routes.login);
      } else {
        sl<HomeProvider>().getHome();
        sl<NavigationService>().navigateToAndRemove(Routes.home);
      }
    } else {
      sl<SharedLocal>().firstIntro = true;
      sl<NavigationService>().navigateToAndRemove(Routes.intro);
    }
  }

  TextTheme getTextContext(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  static showSnakBar(String content, {bool Success = false}) {
    return sl<NavigationService>()
        .snackBarKey
        .currentState
        ?.showSnackBar(SnackBar(
          content: Text(
            content.tr(),
          ),
          backgroundColor: Success ? ColorManager.primary : ColorManager.red,
          behavior: SnackBarBehavior.floating,
        ));
  }

  showException(DioError e) {
    final errorMessage = DioExceptions.fromDioError(e).toString();
    AppConfig.showSnakBar(
        "${e.response != null && e.response!.data["message"] != "" ? e.response!.data["message"] : errorMessage}",
        Success: false);
  }
}
