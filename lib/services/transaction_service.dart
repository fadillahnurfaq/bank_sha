import 'dart:io';

import 'package:bank_sha/models/data_plan/data_plan_form_model.dart';
import 'package:bank_sha/models/top_up/top_up_form_model.dart';
import 'package:bank_sha/models/transaction/transaction_model.dart';
import 'package:bank_sha/models/transfer/transfer_form_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../utils/app_constant.dart/app_constant.dart';
import '../utils/dio_exception/dio_exception.dart';
import 'auth_service.dart';

class TransactionService {
  final Dio _dio = Dio();

  Future<Either<String, List<TransactionModel>>> getTransactions() async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.get(
        AppConstant.getTransactions(),
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

        List<TransactionModel> data =
            response.map((e) => TransactionModel.fromJson(e)).toList();

        return right(data);
      }
      return left("Data Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();
      return left(error);
    }
  }

  Future<Either<String, String>> dataPlan(DataPlanFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.post(
        AppConstant.dataPlan(),
        options: Options(
          method: "POST",
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

  Future<Either<String, String>> topUp(TopUpFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.post(
        AppConstant.topUp(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': token,
          },
        ),
        data: data.toJson(),
      );

      if (res.statusCode == 200 && res.data != null) {
        return right(res.data["redirect_url"]);
      }
      return left("Data Kosong");
    } on DioError catch (e) {
      final error =
          DioException.fromDioError(e, e.response?.data["message"]).toString();
      return left(error);
    }
  }

  Future<Either<String, String>> transfer(TransferFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.post(
        AppConstant.transfer(),
        options: Options(
          method: "POST",
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
}
