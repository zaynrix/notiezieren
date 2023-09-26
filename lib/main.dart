import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notienziert/features/Home/homePro.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/theme_manager.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/routing/router.dart';
import 'package:notienziert/routing/routes.dart';
import 'package:notienziert/utils/appConfig.dart';
import 'package:provider/provider.dart';

//  PR TEST
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Localization
  await EasyLocalization.ensureInitialized();

  // Screen Utils Initialize
  await ScreenUtil.ensureScreenSize();

  // DI
  await init();

  // Introduction Show & User Token
  sl<AppConfig>().loadData();

  // Device Status Bar Color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      startLocale: Locale("en"),
      fallbackLocale: const Locale("en"),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            StreamProvider<InternetConnectionStatus>(
                initialData: InternetConnectionStatus.connected,
                create: (_) {
                  return InternetConnectionChecker().onStatusChange;
                }),
            ChangeNotifierProvider.value(
              value: sl<HomeProvider>(),
            ),
            ChangeNotifierProvider.value(
              value: sl<SettingProvider>(),
            ),
          ],
          //
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            scaffoldMessengerKey: sl<NavigationService>().snackBarKey,
            debugShowCheckedModeBanner: false,
            title: 'notienziert',
            theme: getApplicationTheme(),
            navigatorKey: sl<NavigationService>().navigatorKey,
            initialRoute: Routes.splash,
            onGenerateRoute: RouterX.generateRoute,
          ),
        );
      },
    );
  }
}
