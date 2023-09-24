import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:notienziert/api/endPoints.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/api/remote/auth_api.dart';
import 'package:notienziert/features/Home/homePro.dart';
import 'package:notienziert/features/Registrations/auth_provider.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/repository/home_repo/task_repo.dart';
import 'package:notienziert/repository/setting_repo/srtting_repo.dart';
import 'package:notienziert/repository/user_repo/login_repo.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/utils/appConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_interceptor.dart';
import 'logger_interceptor.dart';

final sl = GetIt.instance;
Future<void> init() async {
  Dio client = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 50),
      receiveTimeout: Duration(seconds: 50),
      responseType: ResponseType.json,
      baseUrl: '${Endpoints.baseUrl}',
      contentType: 'application/json',
    ),
  );
  sl.registerLazySingleton<Dio>(() => client);

  client
    ..interceptors
    ..interceptors.addAll([
      DioInterceptor(),
      if (kDebugMode) LoggerInterceptor(),
    ]);
  sl.registerLazySingleton(() => AppConfig());
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => LoginRepository());
  sl.registerLazySingleton(() => SettingRepository());
  sl.registerLazySingleton(() => HomeRepository());

  sl.registerLazySingleton(() => HomeProvider());
  sl.registerLazySingleton(() => SettingProvider());
  sl.registerLazySingleton(() => AuthProvider());
  sl.registerLazySingleton<HttpAuth>(() => HttpAuth(client: sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<SharedLocal>(
    () => SharedLocal(
      sharedPreferences: sl(),
    ),
  );
}
