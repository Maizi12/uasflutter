import 'package:dartz/dartz.dart';
import 'package:digit/core/client/exceptions.dart';

abstract class AuthRepository {
  Future<Either<ServerFailure, String>> login(String userName, String password);
  // Future<Either<Failure, void>> logout();
  Future<Either<ServerFailure, String>> getEncryptionKey();
  // Future<Either<Failure, User>> getCurrentUser();
}
