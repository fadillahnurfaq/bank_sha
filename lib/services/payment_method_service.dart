import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/transaction/transaction_model.dart';
import '../utils/app_constant.dart/app_constant.dart';
import '../utils/dio_exception/dio_exception.dart';
import 'auth_service.dart';

class PaymentMethodService {
  final Dio _dio = Dio();

  Future<Either<String, List<PaymentMethodModel>>> getPaymentMethods() async {
    try {
      final token = await AuthService().getToken();
      final res = await _dio.get(
        AppConstant.paymentMethods(),
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
        List<PaymentMethodModel> data =
            response.map((e) => PaymentMethodModel.fromJson(e)).toList();
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
