import 'package:dartz/dartz.dart';
import 'package:digit/core/client/exceptions.dart';
import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/domain/repositories/golang-repository.dart';
import 'package:digit/domain/services/hive/hive.dart';
import 'package:digit/domain/usecases/get_request_use_case.dart';
import 'package:digit/domain/usecases/post_request_use_case.dart';

abstract class AuthRemoteDataSource {
  Future<Either<ServerFailure, String>> login(String userName, String password);
  Future<Either<ServerFailure, String>> getEncryptionKey();
  // Future<UserModel> getCurrentUser(String token);
}

class AuthRemoteDataSourceImpl with BoxMixin implements AuthRemoteDataSource {
  final PostRequestUseCase postUseCase;
  final GetRequestUseCase getUseCase;

  AuthRemoteDataSourceImpl(this.postUseCase, this.getUseCase);

  @override
  Future<Either<ServerFailure, String>> login(
      String userName, String password) async {
    final response = await postUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Login}',
        isUseToken: false,
        moreHeader: await UserRepository().login(userName, password),
        data: {},
        queryParam: {});
    return response.fold(
      (error) {
        return Left(ServerFailure(error.statusCode, error.message));
      },
      (right) async {
        await removeData(KeyStorage.accessToken);
        await addData(KeyStorage.accessToken, right.data);
        return Right(right.data);
      },
    );
  }

  @override
  Future<Either<ServerFailure, String>> getEncryptionKey() async {
    try {
      final response = await getUseCase.call(
        url:
            "${AppConstants.API}${AppConstants.DigitEnkrip}${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}",
        isUseToken: false,
        moreHeader: await UserRepository().GetKey(),
      );
      return response.fold(
        (error) {
          return Left(ServerFailure(error.statusCode, error.message));
        },
        (right) async {
          await addData(KeyStorage.enkripKey, right.data);
          print(BoxMixin().getData(KeyStorage.enkripKey));
          return Right(right.data["key"]);
        },
      );
    } catch (e) {
      return Left(ServerFailure(400, "$e Unhandled Error"));
    }
  }

  // Other methods...
}
