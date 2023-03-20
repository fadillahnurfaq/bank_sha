import 'dart:io';

import 'package:bank_sha/models/auth/sign_up_form_model.dart';
import 'package:bank_sha/models/user/user_model.dart';
import 'package:bank_sha/utils/app_constant.dart/app_constant.dart';
import 'package:bank_sha/utils/dio_exception/dio_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth/sign_in_form_model.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Either> checkEmail(String email) async {
    try {
      final res = await _dio.post(
        AppConstant.checkEmail(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: {"email": email},
      );
      if (res.statusCode == 200 && res.data != null) {
        return right(res.data["is_email_exist"]);
      }

      return left("Respose Kosong");
    } on DioError catch (e) {
      final error = DioException.fromDioError(
              e, e.response?.data["errors"]["email"].first)
          .toString();
      return left(error);
    }
  }

  Future<Either<String, UserModel>> register(SignUpFormModel data) async {
    try {
      final res = await _dio.post(
        AppConstant.register(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: data.toJson(),
      );
      if (res.statusCode == 200 && res.data != null) {
        UserModel user = UserModel.fromJson(res.data);
        user = user.copywith(password: data.password);
        await storeCredentialToLocal(user);

        return right(user);
      }
      return left("Respose Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();
      return left(error);
    }
  }

  Future<Either<String, UserModel>> login(SignInFormModel data) async {
    try {
      final res = await _dio.post(
        AppConstant.login(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: data.toJson(),
      );
      if (res.statusCode == 200 && res.data != null) {
        UserModel user = UserModel.fromJson(res.data);
        user = user.copywith(password: data.password);
        await storeCredentialToLocal(user);

        return right(user);
      }
      return left("Respose Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();

      return left(error);
    }
  }

  Future<Either<String, String>> logout() async {
    try {
      final token = await getToken();
      final res = await _dio.post(
        AppConstant.logout(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': token,
          },
        ),
      );
      if (res.statusCode == 200 && res.data != null) {
        clearLocalStorage();
        return right(res.data["message"]);
      }
      return left("Respose Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();

      return left(error);
    }
  }

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();

      Map<String, String> values = await storage.readAll();

      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        final SignInFormModel data = SignInFormModel(
          email: values['email'],
          password: values['password'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer $value';
    }

    return token;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();

    await storage.deleteAll();
  }
}
