import 'package:dartz/dartz.dart';
import 'package:digit/core/client/exceptions.dart';
import 'package:digit/data/datasources/auth_local_datasource.dart';
import 'package:digit/data/datasources/auth_remote_datasource.dart';
import 'package:digit/domain/repository/auth_repository.dart';

// lib/domain/repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(
      this._remoteDataSource, AuthLocalDataSource authLocalDataSource);

  @override
  Future<Either<ServerFailure, String>> login(
      String userName, String password) async {
    try {
      final response = await _remoteDataSource.login(userName, password);
      return response;
    } catch (e) {
      return Left(ServerFailure(401, "$e"));
    }
  }

  // @override
  // Future<Either<Failure, void>> logout() async {
  //   try {
  //     await _localDataSource.clearToken();
  //     return const Right(null);
  //   } catch (e) {
  //     // return Left(CacheFailure());
  //   }
  // }

  @override
  Future<Either<ServerFailure, String>> getEncryptionKey() async {
    try {
      final response = await _remoteDataSource.getEncryptionKey();
      return response.fold((error) {
        return Left(error);
      }, (right) async {
        return Right(right);
      });
    } catch (e) {
      return Left(ServerFailure(500, "$e"));
    }
  }
}
