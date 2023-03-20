import 'dart:io';

import 'package:bank_sha/models/auth/edit_form_model.dart';
import 'package:bank_sha/models/user/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../utils/app_constant.dart/app_constant.dart';
import '../utils/dio_exception/dio_exception.dart';
import 'auth_service.dart';

class UserService {
  final Dio _dio = Dio();

  Future<Either<String, List<UserModel>>> getRecentUsers() async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.get(
        AppConstant.getRecentUsers(),
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': token,
          },
        ),
      );

      if (res.statusCode == 200 && res.data["data"].isNotEmpty) {
        List response = res.data["data"];

        List<UserModel> data =
            response.map((e) => UserModel.fromJson(e)).toList();

        return right(data);
      }
      return left("Data Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();
      return left(error);
    }
  }

  Future<Either<String, List<UserModel>>> getUsersByUsername(
      String username) async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.get(
        AppConstant.getUsersByUsername(username),
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': token,
          },
        ),
      );

      if (res.statusCode == 200 && res.data.isNotEmpty) {
        List response = res.data;

        List<UserModel> data =
            response.map((e) => UserModel.fromJson(e)).toList();

        return right(data);
      }
      return left("Data Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();
      return left(error);
    }
  }

  Future<Either<String, String>> updateUser(EditFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.put(
        AppConstant.editProfile(),
        options: Options(
          method: "PUT",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': token,
          },
        ),
        data: data.toJson(),
      );

      if (res.statusCode == 200 && res.data != null) {
        return right(res.data["message"]);
      }
      return left("Data Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();
      return left(error);
    }
  }

  Future<Either<String, String>> updatePin(String oldPin, String newPin) async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.put(
        AppConstant.updatePin(),
        options: Options(
          method: "PUT",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': token,
          },
        ),
        data: {
          'previous_pin': oldPin,
          'new_pin': newPin,
        },
      );

      if (res.statusCode == 200 && res.data != null) {
        return right(res.data["message"]);
      }
      return left("Data Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();
      return left(error);
    }
  }
}
