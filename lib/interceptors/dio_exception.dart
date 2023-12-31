import 'package:dio/dio.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/routing/routes.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";

        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.unknown:
        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet';

          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        if (sl<SharedLocal>().getUser().token == null) {
        } else {
          sl<SharedLocal>().removeUser();
          sl<NavigationService>().navigateToAndRemove(Routes.login);
        }
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return "Not Found";
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
