import 'dart:io';

import 'package:bank_sha/models/tips/tip_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../utils/app_constant.dart/app_constant.dart';
import '../utils/dio_exception/dio_exception.dart';
import 'auth_service.dart';

class TipService {
  final Dio _dio = Dio();

  Future<Either<String, List<TipModel>>> getTips() async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.get(
        AppConstant.tips(),
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

        List<TipModel> data =
            response.map((e) => TipModel.fromJson(e)).toList();

        return right(data);
      }
      return left("Data Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();
      return left(error);
    }
  }
}
