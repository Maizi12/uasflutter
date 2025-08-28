import 'package:digit/core/client/client.dart';
import 'package:digit/data/datasources/remotedata_source.dart';
import 'package:digit/data/models/general_response.dart';
import 'package:digit/domain/repository/repository.dart';
import 'package:digit/domain/services/hive/hive.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final BoxMixin boxMixin;

  const RepositoryImpl(this.remoteDataSource, this.boxMixin);

  @override
  Future<Either<Failure, GeneralResponse>> getRequest({
    required String url,
    required Map<String, dynamic> queryParam,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  }) async {
    final response = await remoteDataSource.getRequest(
      url: url,
      queryParam: queryParam,
      moreHeader: moreHeader,
      isUseToken: isUseToken,
      service: service,
    );
    return response.fold(
      (left) => Left(left),
      (right) => Right(right),
    );
  }

  @override
  Future<Either<Failure, GeneralResponse>> postRequest({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, dynamic> queryParameters,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
  }) async {
    final response = await remoteDataSource.postRequest(
      url: url,
      data: data,
      queryParam: queryParameters,
      moreHeader: moreHeader,
      isUseToken: isUseToken,
      service: service,
    );
    return response.fold(
      (left) => Left(left),
      (right) => Right(right),
    );
  }

  @override
  Future<Either<Failure, GeneralResponse>> postFormData({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, String> moreHeader,
    required bool isUseToken,
    required ServiceBackend service,
    required Map<String, dynamic> queryParam,
  }) async {
    final response = await remoteDataSource.postRequest(
      url: url,
      data: data,
      queryParam: queryParam,
      moreHeader: moreHeader,
      isUseToken: isUseToken,
      service: service,
    );
    return response.fold(
      (left) => Left(left),
      (right) => Right(right),
    );
  }
}
