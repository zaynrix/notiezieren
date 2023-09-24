import 'package:dio/dio.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Home/homePro.dart';
import 'package:notienziert/utils/appConfig.dart';

import '../features/Registrations/auth_provider.dart';
import 'di.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    sl<HomeProvider>().changeLoader(true);
    sl<AuthProvider>().changeLoaderAuth(true);
    options.headers['Authorization'] =
        "Bearer ${sl<SharedLocal>().getUser().token}";
    options.headers["lang"] = "${sl<SharedLocal>().getLanguage}";
    options.headers["Content-Type"] = "application/json";
    options.headers["X-Requested-With"] = "XMLHttpRequest";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    sl<HomeProvider>().changeLoader(false);
    sl<AuthProvider>().changeLoaderAuth(false);
    super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    sl<AuthProvider>().changeLoaderAuth(false);
    sl<HomeProvider>().changeLoader(false);
    sl<HomeProvider>().changeInit(false);
    AppConfig().showException(err);

    // super.onError(err, handler);
  }
}
