import 'package:dartz/dartz.dart';
import 'package:digit/core/client/client.dart';
import 'package:digit/data/models/general_response.dart';

abstract class Repository {
  Future<Either<Failure, GeneralResponse>> getRequest({
    required String url,
    required Map<String, dynamic> queryParam,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  });
  Future<Either<Failure, GeneralResponse>> postRequest({
    required String url,
    required Map<String, dynamic> queryParameters,
    required Map<String, dynamic> data,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  });
  Future<Either<Failure, GeneralResponse>> postFormData({
    required String url,
    required Map<String, dynamic> queryParam,
    required Map<String, dynamic> data,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  });
}
