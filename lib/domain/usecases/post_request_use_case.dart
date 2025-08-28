import 'package:digit/core/client/client.dart';
import 'package:digit/data/models/general_response.dart';
import 'package:dartz/dartz.dart';
import 'package:digit/domain/repository/repository.dart';

class PostRequestUseCase {
  final Repository _repository;

  const PostRequestUseCase(this._repository);

  Future<Either<Failure, GeneralResponse>> call({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String> moreHeader = const {},
    required Map<String, dynamic> queryParam,
    bool isUseToken = true,
    ServiceBackend service = ServiceBackend.digituser,
  }) async {
    return _repository.postRequest(
      url: url,
      data: data,
      queryParameters: queryParam,
      moreHeader: moreHeader,
      isUseToken: isUseToken,
      service: service,
    );
  }
}
