import 'package:dio/dio.dart';

class DioException implements Exception {
  late String message;

  DioException.fromDioError(DioError e, dynamic error) {
    switch (e.type) {
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
        if (e.response?.statusCode == 400) {
          message = error;
        } else if (e.response?.data.toString().contains("DOCTYPE") == true) {
          message = "Something went wrong";
        } else {
          message = error;
        }

        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.unknown:
        message = 'No Internet';

        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  // String _handleError(int? statusCode, dynamic error) {
  //   switch (statusCode) {
  //     case 400:
  //       return 'Bad request';
  //     case 401:
  //       return 'Unauthorized';
  //     case 403:
  //       return 'Forbidden';
  //     case 404:
  //       return error['message'];
  //     case 500:
  //       return 'Internal server error';
  //     case 502:
  //       return 'Bad gateway';
  //     default:
  //       return 'Oops something went wrong';
  //   }
  // }

  @override
  String toString() => message;
}
